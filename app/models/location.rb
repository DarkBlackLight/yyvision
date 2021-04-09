class Location < ApplicationRecord
  has_ancestry

  scope :query_physical, -> (q) { where(physical: q) }
  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_event_id, -> (q) { joins(:setting_events).where(setting_events: {event_id: q}) }
  scope :query_location_level_name, -> (q) { joins(:location_level).where(:'location_level_id' => q) }
  belongs_to :engine

  belongs_to :location_category, optional: true
  belongs_to :location_level, optional: true

  has_many :location_events, dependent: :destroy
  has_many :actual_events, through: :location_events, class_name: 'Event', source: :event

  has_many :event_locations, dependent: :destroy
  has_many :setting_events, through: :event_locations, class_name: 'Event', source: :event

  has_many :cameras

  has_many :problems

  accepts_nested_attributes_for :event_locations, allow_destroy: true

  before_validation :setup_engine

  validates :name, presence: true

  def setup_engine
    self.engine = parent&.engine ? parent.engine : Engine.where(engine_type: :engine).first unless engine
  end

  def all_descendant_locations
    Location.where(id: self.descendant_ids)
  end

  def all_descendant_location_events
    LocationEvent.where(location_id: self.descendant_ids)
  end

  def all_descendant_problems
    Problem.where(location_id: self.descendant_ids)
  end

  def all_descendant_cameras
    Camera.where(location_id: self.descendant_ids)
  end
end
