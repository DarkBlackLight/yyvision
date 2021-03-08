class Upload < ApplicationRecord
  include IfaceConcern

  belongs_to :admin

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  after_create_commit :setup_portraits
  has_one_attached :img

  enum upload_type: [:portrait]

  def img_data
    img.attached? ? { src: url_for(img), filename: img.filename, content_type: img.content_type } : nil
  end

  def setup_portraits
    if img.attached? && self.portrait?
      path = ActiveStorage::Blob.service.send(:path_for, self.img.key)
      file = URI.open(path) { |io| io.read }
      faces = iface_face_detect(file)

      faces.each do |face|
        face_file = Tempfile.new('face', encoding: 'ascii-8bit')
        begin
          face_file.write(Base64.decode64(face["face_img"]))
          face_file.rewind

          portrait = Portrait.create(
            left_eye: face["left_eye"],
            right_eye: face["right_eye"],
            nose: face["nose"],
            left_mouth: face["left_mouth"],
            right_mouth: face["right_mouth"],
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
