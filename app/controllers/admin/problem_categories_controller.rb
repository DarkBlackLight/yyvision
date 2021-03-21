class Admin::ProblemCategoriesController < Admin::ResourcesController
  include AdminProblemCategoriesConcern

  def filter_params
    params.slice(:query_name, :query_parent, :query_level)
  end

end

