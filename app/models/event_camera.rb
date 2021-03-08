class EventCamera < ApplicationRecord
  belongs_to :camera
  belongs_to :event

  validates :camera_id, uniqueness: { scope: :event_id }
end
