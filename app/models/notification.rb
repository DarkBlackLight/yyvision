class Notification < ApplicationRecord

  belongs_to :admin
  has_many :notification_attachments, dependent: :destroy
  has_many :notification_views, dependent: :destroy

end
