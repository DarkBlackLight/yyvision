class LocationEventCameraCapture < ApplicationRecord
  belongs_to :location_event
  belongs_to :camera_capture

  validates :camera_capture_id, uniqueness: { scope: :location_event_id }
end
