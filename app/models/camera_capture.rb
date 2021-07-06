class CameraCapture < ApplicationRecord
  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :bodies, as: :source, dependent: :destroy
  accepts_nested_attributes_for :bodies, allow_destroy: true

  belongs_to :camera
  belongs_to :location
  belongs_to :engine

  has_many :location_event_camera_captures, :dependent => :destroy
  has_many :location_events, through: :location_event_camera_captures

  has_one_attached :img, dependent: :purge_later

  before_validation :setup_location
  after_create :update_camera_master

  after_create_commit :broadcast

  def setup_location
    self.location_id = self.camera.location_id unless self.location_id
  end

  def update_camera_master
    self.camera.update_columns(master_camera_capture_id: self.id, updated_at: Time.now)
  end

  def broadcast
    ActionCable.server.broadcast("camera_captures", self.as_json(only: [:id, :created_at],
                                                                 methods: [:img_data],
                                                                 include: [
                                                                   camera: { only: [:id, :status, :name],
                                                                             include: { location: { only: [:id, :name, :location_category_id, :ancestry],
                                                                                                    include: { path: { only: [:id, :name] },
                                                                                                               setting_events: { only: [:name] } } } } },
                                                                   bodies: { only: [:id] },
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
