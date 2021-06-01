module AdminAttendancesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_person_id)
    end

  end
end
