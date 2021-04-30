class LocationLevel < ApplicationRecord

  has_many :locations

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }

end
