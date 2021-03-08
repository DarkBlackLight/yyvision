module FaceAdminProblemCategoriesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def resource_params
      params.require(:problem_category).permit(:name, :parent_id, :level)
    end
  end
end
