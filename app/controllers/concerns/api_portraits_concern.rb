module ApiPortraitsConcern
  extend ActiveSupport::Concern
  included do
    def create
      file = File.read(params[:portrait][:img].path)
      faces = vision_face_detect(file, 0.7)

      if faces.size > 1
        render json: { data: 'Your Image Has multiple Faces' }, status: :unprocessable_entity
      elsif faces.size == 0
        render json: { data: 'Your Image does not have any faces' }, status: :unprocessable_entity
      else
        face = faces[0]

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

    def filter_params
      params.slice(:query_source_type)
    end

    def show_json(resource)
      resource.as_json(only: [:id, :features])
    end

    def resource_params
      params.require(:portrait).permit(:id, :img, :engine_id, :img_url, :source_id, :source_type, :confidence, features: [], box: [])
    end
  end
end
