class Holiday < ApplicationRecord

  scope :query_name, -> (q) { where('lower(off_date) like lower(?)', "%#{q.downcase}%") }

end
