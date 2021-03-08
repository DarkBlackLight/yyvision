class BankPerson < ApplicationRecord
  belongs_to :bank
  belongs_to :person

  validates :person_id, uniqueness: { scope: :bank_id }
end
