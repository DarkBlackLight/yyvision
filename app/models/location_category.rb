class LocationCategory < ApplicationRecord

  belongs_to :parent, class_name: 'LocationCategory', optional: true
  has_many :children, class_name: 'LocationCategory'

  has_many :locations

end
