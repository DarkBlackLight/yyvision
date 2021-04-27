class LocationCategory < ApplicationRecord
  has_ancestry
  has_many :locations

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }
  scope :query_level, ->(q) { where index: q }
  scope :query_parent, ->(q) { where ancestry: q }

end
