class Location < ApplicationRecord
  has_ancestry

  scope :query_physical, -> (q) { where(physical: q) }
  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_event_id, -> (q) { joins(:event_locations).where(event_locations: { event_id: q }) }
  scope :query_location_level_name, -> (q) { joins(:location_level).where(location_levels: { name: q }) }
  scope :query_location_level_id, -> (q) { where(location_level_id: q) }
  scope :query_ancestry, ->(q) { where ancestry: q }
  scope :query_parent_id, -> (q) { children_of(q) }

  belongs_to :engine

  belongs_to :location_category, optional: true
  belongs_to :location_level, optional: true

  has_many :location_events, dependent: :destroy
  has_many :actual_events, through: :location_events, class_name: 'Event', source: :event

  has_many :event_locations, dependent: :destroy
  accepts_nested_attributes_for :event_locations, allow_destroy: true
  has_many :setting_events, through: :event_locations, class_name: 'Event', source: :event

  has_many :cameras, dependent: :destroy
  has_many :problems, dependent: :destroy

  before_validation :setup_engine

  validates :name, presence: true

  after_update_commit :setup_event_cameras

  def setup_engine
    self.engine = parent&.engine ? parent.engine : Engine.where(engine_type: :capture).first unless engine
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

  def setup_event_cameras
    cameras.each do |camera|
      event_camera_ids = []
      event_locations.each do |event_location|
        event_camera = EventCamera.find_or_create_by(event: event_location.event, camera: camera)
        event_camera_ids.append(event_camera.id)
      end
      camera.event_cameras.where.not(id: event_camera_ids).destroy_all
    end
  end

end
