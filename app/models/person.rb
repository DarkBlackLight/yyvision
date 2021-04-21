class Person < ApplicationRecord
  scope :query_name, -> (q) { where(name: q) }
  scope :query_bank_id, -> (q) { joins(:banks).where(banks: { id: q }) }

  belongs_to :master_portrait, class_name: 'Portrait', optional: true

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :bank_people, dependent: :destroy
  has_many :banks, through: :bank_people

  validates :name, presence: true

end
