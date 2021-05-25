module ApiProblemCategoriesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice()
    end

    def set_show_json(resource)
      resource.as_json(only: [:name, :parent_id, :level])
    end

    def resource_params
      params.require(:problem_category).permit(:name, :parent_id, :level)
    end

  end
end
