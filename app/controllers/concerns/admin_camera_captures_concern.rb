module AdminCameraCapturesConcern
  extend ActiveSupport::Concern
  included do

    def history
      @resources = CameraCapture.accessible_by(current_ability, :read).filterable(params.slice(
        :query_location_id, :query_location_id_0, :query_location_id_1, :query_location_id_2, :query_location_id_3, :query_location_id_4,:query_created_at_from, :query_created_at_to))
                                .order(created_at: :desc).page(params[:page]).per(10)
    end


    private

    def filter_params
      params.slice(:query_location_id, :query_location_id_0, :query_location_id_1, :query_location_id_2, :query_location_id_3, :query_location_id_4,:query_created_at_from, :query_created_at_to)
    end


    def resource_params
      params.require(:camera_capture).permit(:location_id, :camera_id, :engine_id, :img, :img_url, :bodies_count, :portraits_count, :created_at)
    end

  end
end
