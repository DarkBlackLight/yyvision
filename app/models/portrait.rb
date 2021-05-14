class Portrait < ApplicationRecord
  include RailsSortable::Model
  set_sortable :index

  serialize :box, Array
  serialize :features, Array

  scope :query_source_type, -> (q) { where(source_type: q) }

  belongs_to :source, polymorphic: true, counter_cache: true
  belongs_to :target, class_name: 'Portrait', optional: true

  belongs_to :engine, optional: true

  has_many :portrait_searches, :dependent => :destroy

  has_one_attached :img

  before_create :format_features
  before_create :milvus_search

  after_save :update_person
  after_destroy :update_person

  after_create_commit :milvus_setup
  after_commit :broadcast

  validates :features, presence: true

  def format_features
    self.features = self.features.map { |feature| feature.to_f }
    self.box = self.box.map { |box| box.to_f }
  end

  def milvus_search
    if self.source_type == 'CameraCapture'
      vectors = milvus_search_vectors('Person', self, 1)
      if vectors.size > 0
        self.target_id = vectors[0]["id"]
        self.target_confidence = milvus_confidence(vectors[0]["distance"])
      end
    end
  end

  def update_person
    if self.source_type == 'Person'
      self.source.master_portrait = self.source.portraits.order(:index).first
      self.source.save
    end
  end

  def milvus_setup
    milvus_create_vector(self.source_type, self) if self.source_type == 'Person' || self.source_type == 'CameraCapture'
  end

  def broadcast
    ActionCable.server.broadcast("portraits", self.as_json(only: [:id, :source_type, :target_confidence, :created_at],
                                                           methods: [:img_data],
                                                           include: [target: { only: [],
                                                                               include: [source: { only: [:name],
                                                                                                   include: { portraits: { only: [], methods: [:img_data] } } }] }]))
  end

  def img_data
    if img.attached?
      { src: url_for(img), filename: img.filename, content_type: img.content_type }
    else
      self.img_url ? { src: 'http://' + self.engine.external_address + self.img_url } : nil
    end
  end

end
