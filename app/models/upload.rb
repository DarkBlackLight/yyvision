class Upload < ApplicationRecord
  belongs_to :admin

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  enum upload_type: [:portrait]

  after_create_commit :setup_portraits
  has_one_attached :img

  def img_data
    img.attached? ? { src: url_for(img), filename: img.filename, content_type: img.content_type } : nil
  end

  def setup_portraits
    if img.attached? && self.portrait?
      path = ActiveStorage::Blob.service.send(:path_for, self.img.key)
      file = URI.open(path) { |io| io.read }
      faces = vision_face_detect(file, 0.8)

      faces.each do |face|
        face_file = Tempfile.new('face', encoding: 'ascii-8bit')
        begin
          face_file.write(Base64.decode64(face["face_img"]))
          face_file.rewind

          portrait = Portrait.create(
            features: face["features"],
            box: face["box"],
            confidence: face["confidence"],
            source_id: self.id,
            source_type: 'Upload'
          )

          portrait.img.attach(io: face_file, filename: 'face.jpg')
        ensure
          face_file.close
          face_file.unlink
        end
      end
    end
  end

end
