class EventTimeRange < ApplicationRecord
  belongs_to :event

  validates :start_time, :end_time, presence: true
end
