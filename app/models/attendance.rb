class Attendance < ApplicationRecord
  scope :query_person_id, -> (q) { where(person_id: q) }

  belongs_to :person
  belongs_to :portrait
end
