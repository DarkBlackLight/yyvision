class Notification < ApplicationRecord

  belongs_to :admin
  has_many :notification_attachments, dependent: :destroy
  accepts_nested_attributes_for :notification_attachments, allow_destroy: true
  has_many :notification_views, dependent: :destroy

end
