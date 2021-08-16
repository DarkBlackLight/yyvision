module AdminLocationEventsConcern
  extend ActiveSupport::Concern
  included do

    private

    def index_order_by
      'active_at desc'
    end

    def filter_params
      params.slice(:query_active, :query_location_id_0, :query_location_id_1, :query_location_id_2, :query_location_id_3, :query_location_id_4, :query_event_id, :query_created_at_from, :query_created_at_to,)
    end

    def resource_params
      params.require(:location_event).permit(:active, :location_id, :event_id, :active_at, :length, :problem_id, :video_url, :master_camera_capture_id)
    end

  end
end
