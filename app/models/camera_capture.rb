class CameraCapture < ApplicationRecord
  include IfaceConcern

  has_many :portraits, as: :source, dependent: :destroy
  accepts_nested_attributes_for :portraits, allow_destroy: true

  has_many :bodies, as: :source, dependent: :destroy
  accepts_nested_attributes_for :bodies, allow_destroy: true

  belongs_to :camera

  has_many :location_event_camera_captures, :dependent => :destroy
  has_many :location_events, through: :location_event_camera_captures

  has_one_attached :img

  before_validation :setup_location
  after_create :update_camera_master
  # after_create :search_iface_face
  # after_create :post_iface_face

  after_create_commit :broadcast

  def setup_location
    self.location_id = self.camera.location_id unless self.location_id
  end

  def update_camera_master
    self.camera.update_columns(master_camera_capture_id: self.id, status: 'normal', updated_at: Time.now)
  end

  # def search_iface_face
  #   if self.portraits.size > 0
  #     results = iface_faces_search(self.portraits, 'Person')
  #     if results.size > 0
  #       self.portraits.each_with_index do |portrait, index|
  #         portrait.update_columns(target_id: results[index][0]["target_id"], target_confidence: results[index][0]["target_confidence"]) if results[index].size > 0
  #       end
  #     end
  #   end
  # end

  # def post_iface_face
  #   if self.portraits.size > 0
  #     iface_faces_post(self.portraits, 'CameraCapture')
  #   end
  # end

  def broadcast
    ActionCable.server.broadcast("camera_captures", self.as_json(only: [:id, :created_at],
                                                                 methods: [:img_data],
                                                                 include: [
                                                                   camera: { only: [:id, :name], include: { location: { only: [:id, :name], include: [setting_events: { only: [:name] }] } } },
                                                                   portraits: { only: [:id, :target_confidence],
                                                                                methods: [:img_data],
                                                                                include: [target: { only: [],
                                                                                                    include: [source: { only: [:name],
                                                                                                                        include: { portraits: { only: [], methods: [:img_data] } } }] }] }]))
  end

  def img_data
    img.attached? ? { src: url_for(img), filename: img.filename, content_type: img.content_type } : nil
  end

end
