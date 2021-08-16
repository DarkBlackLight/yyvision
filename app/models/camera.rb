class Camera < ApplicationRecord

  has_many :event_cameras, dependent: :destroy
  has_many :camera_captures
  belongs_to :location

  belongs_to :master_camera_capture, class_name: "CameraCapture", optional: true

  enum status: [:normal, :offline, :corrupted]

  after_create :create_event_cameras

  after_commit :setup_location
  after_destroy :setup_location

  # validates :rtsp, uniqueness: true
  # validates :rtsp, presence: true

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_status, ->(q) { where status: q }
  scope :query_event_id, -> (q) { joins(:event_cameras).where(event_cameras: { event_id: q }).distinct }
  scope :query_location_id, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_marked, ->(q) { where marked: q }

  scope :query_location_id_0, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_1, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_2, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_3, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_4, -> (q) { where(location_id: Location.find(q).subtree_ids) }

  def create_event_cameras
    location.event_locations.each do |event_location|
      EventCamera.create(event: event_location.event, camera: self)
    end
  end

  def setup_location
    location.update_column(:physical, true)
  end

end
