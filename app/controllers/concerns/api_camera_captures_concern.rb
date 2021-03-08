module ApiCameraCapturesConcern
  extend ActiveSupport::Concern
  included do

    private

    def resource_params
      params.require(:camera_capture).permit(:camera_id, :engine_id, :img, :created_at,
                                             portraits_attributes: [:img, :confidence, :target_id, :target_confidence,
                                                                    left_eye: [], right_eye: [], nose: [], left_mouth: [],
                                                                    right_mouth: [], features: [], box: []],
                                             bodies_attributes: [:confidence, box: []])
    end

    def set_show_json(resource)
      resource.as_json(only: [:id])
    end

  end
end
