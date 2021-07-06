class ProblemCorrection < ApplicationRecord

  belongs_to :problem

  has_one_attached :img, dependent: :purge_later

  def img_data
    img.attached? ? { src: url_for(img), filename: img.filename, content_type: img.content_type } : nil
  end

end
