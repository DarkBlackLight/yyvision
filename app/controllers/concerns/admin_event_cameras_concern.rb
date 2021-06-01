module AdminEventCamerasConcern
  extend ActiveSupport::Concern
  included do

    private

    def update_success_path
      url_for({ controller: :cameras, action: :show, id: @resource.camera_id })
    end

    def resource_params
      params.require(:event_camera).permit(:box_a, :box_b, :box_c, :box_d, :line_a, :line_b, :confidence, :threshold)
    end
  end
end
