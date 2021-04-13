module AdminProblemsConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice(:query_discover_type, :query_problem_status, :query_problem_category_id, :query_from_date, :query_to_date, :query_admin_id)
    end

    def resource_params
      params.require(:problem).permit(:reviewing_admin, :reviewing_at, :reviewing_note, :invalidp_user, :invalidp_time, :invalidp, :correction_user, :correction_time, :correction, :problem_status, :discover_type, :problem_category_id, :issued_at, :note, :admin_id, :location_id,
                                      problem_evidences_attributes: [:id, :_destroy])
    end

  end
end
