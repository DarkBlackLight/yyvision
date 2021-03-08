class LocationEvent < ApplicationRecord
  belongs_to :location
  belongs_to :event

  has_many :location_event_camera_captures, dependent: :destroy
  has_many :camera_captures, through: :location_event_camera_captures
  accepts_nested_attributes_for :location_event_camera_captures, allow_destroy: true

  after_commit :broadcast

  def broadcast
    ActionCable.server.broadcast("location_events", self.as_json(only: [:id],
                                                                 include: [location: { only: [:id, :name] },
                                                                           event: { only: [:id, :name] }]))
  end

end
