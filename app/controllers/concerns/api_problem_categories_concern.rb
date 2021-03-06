module ApiProblemCategoriesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice()
    end

    def show_json(resource)
      resource.as_json(only: [:name, :id, :level, :ancestry],
                       include: { parent: { only: [:id, :name] },
                       })
    end

    def resource_params
      params.require(:problem_category).permit(:name, :parent_id, :level)
    end

  end
end
