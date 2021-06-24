class Person < ApplicationRecord
  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q}%") }
  scope :query_bank_id, -> (q) { joins(:banks).where(banks: { id: q }) }

  belongs_to :master_portrait, class_name: 'Portrait', optional: true

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :attendances, dependent: :destroy

  has_many :bank_people, dependent: :destroy
  has_many :banks, through: :bank_people

  before_validation :setup_tag
  validates :name, presence: true

  def setup_tag
    self.if_black = banks.where(if_black: true).size > 0
    self.if_red = banks.where(if_red: true).size > 0
  end
end
