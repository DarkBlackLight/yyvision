module AdminLocationEventsConcern
  extend ActiveSupport::Concern
  included do

    def stats_location_events_group_status
      render json: {correct: LocationEvent.accessible_by(current_ability, :read).filterable(filter_params).where(active: true).size, error: LocationEvent.accessible_by(current_ability, :read).filterable(filter_params).where(active: false ).size}.as_json, status: :ok
    end

    private

    def filter_params
      params.slice(:query_location_id_1, :query_location_id_2, :query_location_id_3, :query_location_id_4, :query_location_id_5, :query_event_id, :query_created_at_from, :query_created_at_to,)
    end

    def resource_params
      params.require(:location_event).permit(:active)
    end

  end
end
