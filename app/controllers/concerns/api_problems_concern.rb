module ApiProblemsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :created_at])
    end

    def resource_params
      params.require(:problem).permit(:location_id, :problem_category_id)
    end

  end
end
