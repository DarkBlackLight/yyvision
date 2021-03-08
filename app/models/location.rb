class Location < ApplicationRecord
  scope :query_physical, -> (q) { where(physical: q) }

  belongs_to :parent, class_name: 'Location', optional: true
  has_many :children, class_name: 'Location'

  validates :name, presence: true

  has_many :location_events, dependent: :destroy
  has_many :actual_events, through: :location_events, class_name: 'Event', source: :event

  has_many :event_locations, dependent: :destroy
  has_many :setting_events, through: :event_locations, class_name: 'Event', source: :event

  has_many :cameras

  accepts_nested_attributes_for :event_locations, allow_destroy: true
end
