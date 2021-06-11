class Bank < ApplicationRecord
  has_ancestry

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }
  scope :query_ancestry, -> (q) { where(ancestry: q) }

  has_many :bank_people, dependent: :destroy
  has_many :people, through: :bank_people
end
