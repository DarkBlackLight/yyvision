module AdminCameraCapturesConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:camera_capture).permit(:location_id, :camera_id, :engine_id, :img, :img_url, :bodies_count, :portraits_count)
    end

  end
end
