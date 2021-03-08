class Bank < ApplicationRecord
  belongs_to :parent, class_name: 'Bank', optional: true
  has_many :children, class_name: 'Bank'

  has_many :bank_people, dependent: :destroy
  has_many :people, through: :bank_people
end
