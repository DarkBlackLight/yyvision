class Admin < ApplicationRecord
  has_one :user, as: :source, dependent: :destroy
  accepts_nested_attributes_for :user

  belongs_to :location, optional: true
end
