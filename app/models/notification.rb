class Notification < ApplicationRecord

  belongs_to :admin
  has_many :notification_attachments, dependent: :destroy
  accepts_nested_attributes_for :notification_attachments, allow_destroy: true
  has_many :notification_views, dependent: :destroy

  scope :query_name, -> (q) { where('lower(name) like lower(?)', "%#{q.downcase}%") }
  scope :query_admin_id, -> (q) { where(admin_id: q) }

end
