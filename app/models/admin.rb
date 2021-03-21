class Admin < ApplicationRecord
  has_one :user, as: :source, dependent: :destroy
  accepts_nested_attributes_for :user

  belongs_to :location, optional: true

  scope :query_name, -> (q) { where('lower(full_name) like lower(?)', "%#{q.downcase}%") }
  scope :query_role, ->(q) { where role: q }
  scope :query_location, -> (q) { joins(:location).where(:'location_id' => q) }

  enum role: [:staff, :admin, :superadmin]
end
