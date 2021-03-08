module FaceAdminPortraitsConcern
  extend ActiveSupport::Concern
  included do
    include IfaceConcern

    def create
      file = File.read(params[:portrait][:img].path)
      faces = iface_face_detect(file)

      if faces.size > 1
        render json: { data: 'Your Image Has multiple Faces' }, status: :unprocessable_entity
      elsif faces.size == 0
        render json: { data: 'Your Image does not have any faces' }, status: :unprocessable_entity
      else
        face = faces[0]
        params["portrait"]["left_eye"] = face["left_eye"]
        params["portrait"]["right_eye"] = face["right_eye"]
        params["portrait"]["nose"] = face["nose"]
        params["portrait"]["left_mouth"] = face["left_mouth"]
        params["portrait"]["right_mouth"] = face["right_mouth"]
        params["portrait"]["features"] = face["features"]
        params["portrait"]["box"] = face["box"]
        params["portrait"]["confidence"] = face["confidence"]

        File.open(params[:portrait][:img].path, 'wb') do |f|
          f.write(Base64.decode64(face["face_img"]))
        end

        super
      end
    end

    private

    def resource_params
      params.require(:portrait).permit(:id, :img, :source_id, :source_type, :confidence,
                                       left_eye: [], right_eye: [], nose: [], left_mouth: [], right_mouth: [], features: [], box: [])
    end
  end
end
