module AdminLocationEventsConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice(:query_active, :query_location_id_1, :query_location_id_2, :query_location_id_3, :query_location_id_4, :query_location_id_5, :query_event_id, :query_created_at_from, :query_created_at_to,)
    end

    def resource_params
      params.require(:location_event).permit(:active)
    end

  end
end
