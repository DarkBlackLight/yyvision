class NotificationAttachment < ApplicationRecord

  belongs_to :notification

  has_one_attached :file, dependent: :purge

  def file_data
    file.attached? ? { src: url_for(file), filename: file.filename, content_type: file.content_type } : nil
  end

end
