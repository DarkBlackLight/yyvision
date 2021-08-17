module AdminCameraCapturesConcern
  extend ActiveSupport::Concern
  included do

    def history
      @resources = CameraCapture.page(params[:page]).per(10)
    end


    private

    def filter_params
      params.slice(:query_location_id)
    end

    def resource_params
      params.require(:camera_capture).permit(:location_id, :camera_id, :engine_id, :img, :img_url, :bodies_count, :portraits_count, :created_at)
    end

  end
end
