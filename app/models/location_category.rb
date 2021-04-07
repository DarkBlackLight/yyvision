class LocationCategory < ApplicationRecord
  has_ancestry
  has_many :locations
end
