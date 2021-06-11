module AdminAttendancesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_person_id, :query_created_at_from, :query_created_at_to)
    end
  end
end
