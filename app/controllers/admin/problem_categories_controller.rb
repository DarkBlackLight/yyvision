class Admin::ProblemCategoriesController < Admin::ResourcesController
  include AdminProblemCategoriesConcern

  def filter_params
    params.slice(:query_name,  :query_level, :query_parent)
  end

end

