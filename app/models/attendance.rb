class Attendance < ApplicationRecord
  scope :query_person_id, -> (q) { where(person_id: q) }
  scope :query_bank_id, -> (q) { joins(:person => :banks).where(banks: { id: Bank.find(q).descendant_ids }) }

  belongs_to :person
  belongs_to :portrait
end
