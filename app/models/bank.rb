class Bank < ApplicationRecord
  has_ancestry

  has_many :bank_people, dependent: :destroy
  has_many :people, through: :bank_people
end
