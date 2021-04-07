class LocationCategory < ApplicationRecord
  has_ancestry
  has_many :locations
  validates :name, uniqueness: { scope: :parent_id }
end
