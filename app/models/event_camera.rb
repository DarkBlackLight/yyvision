class EventCamera < ApplicationRecord
  belongs_to :camera
  belongs_to :event

  validates :camera_id, uniqueness: { scope: :event_id }

  before_validation :setup_event

  def setup_event
    self.enabled = self.event.enabled if self.event && self.enabled == nil
    self.confidence = self.event.confidence if self.event && self.confidence == nil
  end
end
