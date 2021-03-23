class Camera < ApplicationRecord

  has_many :event_cameras, dependent: :destroy
  has_many :camera_captures, dependent: :destroy
  belongs_to :location

  belongs_to :master_camera_capture, class_name: "CameraCapture", optional: true

  enum status: [:normal, :offline]

  after_create :create_event_cameras

  after_create :setup_location
  after_destroy :setup_location

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_status, ->(q) { where status: q }
  scope :query_location_id, -> (q) { joins(:location).where(:'location_id' => q) }

  def create_event_cameras
    location.event_locations.each do |event_location|
      EventCamera.create(event: event_location.event, camera: self)
    end
  end

  def setup_location
    location.physical = true
    location.save!
  end

end
