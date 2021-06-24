module ApiCameraCapturesConcern
  extend ActiveSupport::Concern
  included do

    private

    def resource_params
      params.require(:camera_capture).permit(:camera_id, :engine_id, :img, :img_url, :created_at,
                                             portraits_attributes: [:img, :target_id, :target_confidence, :confidence, features: [], box: []],
                                             bodies_attributes: [:confidence, box: []])
    end

    def show_json(resource)
      resource.as_json(only: [:id])
    end
  end
end
