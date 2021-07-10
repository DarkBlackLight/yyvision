module AdminLocationsConcern
  extend ActiveSupport::Concern
  included do
    
    private

    def filter_params
      params.slice(:query_location_level_id, :query_location_level_name, :query_event_id, :query_name, :query_ancestry, :query_parent_id, :query_location_category_id, :query_location_type, :query_physical)
    end

    def resource_params
      params.require(:location).permit(:location_type, :lat, :lon, :name, :parent_id, :engine_id, :map, :location_level_id, :location_category_id, setting_event_ids: [])
    end
  end
end
