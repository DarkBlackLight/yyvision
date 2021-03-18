class CameraCapture < ApplicationRecord
  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :bodies, as: :source, dependent: :destroy
  accepts_nested_attributes_for :bodies, allow_destroy: true

  belongs_to :camera

  has_many :location_event_camera_captures, :dependent => :destroy
  has_many :location_events, through: :location_event_camera_captures

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
                                                                 include: [
                                                                   camera: { only: [:id, :name], include: { location: { only: [:id, :name], include: [setting_events: { only: [:name] }] } } },
                                                                   portraits: { only: [:id, :target_confidence],
                                                                                methods: [:img_data],
                                                                                include: [target: { only: [],
                                                                                                    include: [source: { only: [:name],
                                                                                                                        include: { portraits: { only: [], methods: [:img_data] } } }] }] }]))
  end

end
