class CameraCapture < ApplicationRecord
  scope :query_created_at_from, -> (q) { where('camera_captures.created_at >= ?', Time.zone.parse(q)) }
  scope :query_created_at_to, -> (q) { where('camera_captures.created_at <= ?', Time.zone.parse(q)) }

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :bodies, as: :source, dependent: :destroy
  accepts_nested_attributes_for :bodies, allow_destroy: true

  belongs_to :camera
  belongs_to :location
  belongs_to :engine

  has_many :location_event_camera_captures, :dependent => :destroy
  has_many :location_events, through: :location_event_camera_captures

  has_one_attached :img

  before_validation :setup_location
  after_create :update_camera_master

  after_create_commit :broadcast

  def setup_location
    self.location_id = self.camera.location_id unless self.location_id
  end

  def update_camera_master
    self.camera.update_columns(master_camera_capture_id: self.id, status: 'normal', updated_at: Time.now)
  end

  def broadcast
    ActionCable.server.broadcast("camera_captures", self.as_json(only: [:id, :img_url, :created_at],
                                                                 methods: [:img_data],
                                                                 include: [
                                                                   camera: { only: [:id, :name], include: { location: { only: [:id, :name], include: [setting_events: { only: [:name] }] } } },
                                                                   portraits: { only: [:id, :target_confidence],
                                                                                methods: [:img_data],
                                                                                include: [target: { only: [],
                                                                                                    include: [source: { only: [:name],
                                                                                                                        include: { portraits: { only: [], methods: [:img_data] } } }] }] }]))
  end

  def img_data
    if img.attached?
      { src: url_for(img), filename: img.filename, content_type: img.content_type }
    else
      self.img_url ? { src: 'http://' + self.engine.external_address + self.img_url } : nil
    end
  end

end
