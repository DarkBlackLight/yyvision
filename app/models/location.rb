class Location < ApplicationRecord
  scope :query_physical, -> (q) { where(physical: q) }

  belongs_to :engine

  belongs_to :location_category, optional: true
  belongs_to :location_level, optional: true

  belongs_to :parent, class_name: 'Location', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Location', foreign_key: 'parent_id'

  has_many :location_events, dependent: :destroy
  has_many :actual_events, through: :location_events, class_name: 'Event', source: :event

  has_many :event_locations, dependent: :destroy
  has_many :setting_events, through: :event_locations, class_name: 'Event', source: :event

  has_many :cameras

  accepts_nested_attributes_for :event_locations, allow_destroy: true

  before_validation :setup_engine

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_parent, -> (q) { where(:parent_id => q) }

  def setup_engine
    self.engine = parent&.engine ? parent.engine : Engine.where(engine_type: :engine).first unless engine
  end

  def all_children
    self.children.inject([self.id]) { |sum, x| sum + x.all_children }
  end

  def all_children_location_events
    LocationEvent.where(location_id: self.all_children)
  end

  def all_children_problems
    Problem.where(location_id: self.all_children)
  end

  def all_children_cameras
    Camera.where(location_id: self.all_children)
  end

end
