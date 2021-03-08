class LocationEventCameraCapture < ApplicationRecord
  belongs_to :location_event
  belongs_to :camera_capture
end
