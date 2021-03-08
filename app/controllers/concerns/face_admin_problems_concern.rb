module FaceAdminProblemsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_problem_category_id)
    end

    def resource_params
      params.require(:problem).permit(:problem_category_id, :issued_at, :note, :admin_id)
    end
  end
end
