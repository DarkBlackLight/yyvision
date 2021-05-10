module AdminProblemCategoriesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name, :query_level, :query_ancestry, :query_parent_id)
    end

    def resource_params
      params.require(:problem_category).permit(:name, :parent_id, :level)
    end
  end
end
