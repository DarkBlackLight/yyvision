module AdminLocationEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def stats_location_events_group_status
      render json: {correct: LocationEvent.accessible_by(current_ability, :read).filterable(filter_params).where(valid: true).size, error: LocationEvent.accessible_by(current_ability, :read).filterable(filter_params).where(valid: false ).size}.as_json, status: :ok
    end

    def filter_params
      params.slice(:query_event_id, :query_created_at_from, :query_created_at_to,)
    end
  end
end
