class Portrait < ApplicationRecord
  include RailsSortable::Model
  set_sortable :index

  serialize :box, Array
  serialize :features, Array

  scope :query_source_type, -> (q) { where(source_type: q) }

  belongs_to :source, polymorphic: true
  belongs_to :target, class_name: 'Portrait', optional: true

  has_many :portrait_searches, :dependent => :destroy

  has_one_attached :img

  after_save :update_person
  after_destroy :update_person

  after_create :post_iface_face

  after_commit :broadcast

  validates :features, presence: true

  def update_person
    if self.source_type == 'Person'
      self.source.master_portrait = self.source.portraits.order(:index).first
      self.source.save
    end
  end

  def post_iface_face
    if self.source_type == 'Person'
      iface_faces_post([self], 'Person')
    end
  end

  def broadcast
    ActionCable.server.broadcast("portraits", self.as_json(only: [:id, :source_type, :target_confidence, :created_at],
                                                           methods: [:img_data],
                                                           include: [target: { only: [],
                                                                               include: [source: { only: [:name],
                                                                                                   include: { portraits: { only: [], methods: [:img_data] } } }] }]))
  end

  def img_data
    img.attached? ? { src: url_for(img), filename: img.filename, content_type: img.content_type } : nil
  end

end
