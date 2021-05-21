class EventLocation < ApplicationRecord
  belongs_to :location
  belongs_to :event

  validates :location_id, uniqueness: { scope: :event_id }

  after_create :create_event_cameras
  after_destroy :destroy_event_cameras

  def create_event_cameras
    location.cameras.each do |camera|
      EventCamera.create(event: self.event, camera: camera)
    end
  end

  def destroy_event_cameras
    EventCamera.joins(:camera).where(cameras: { location_id: self.location_id }, event: self.event_id).destroy_all
  end
end
