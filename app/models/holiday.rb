class Holiday < ApplicationRecord

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }

end
