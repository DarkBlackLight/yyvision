class Event < ApplicationRecord
  validates :name, :nickname, presence: true

  has_many :event_time_ranges, dependent: :destroy
  accepts_nested_attributes_for :event_time_ranges, allow_destroy: true

  has_many :location_events, dependent: :destroy
  has_many :event_locations, dependent: :destroy
end
