module ApiProblemsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :issued_at, :created_at], include: { location: { include: { path: { only: [:id, :name] } } } })
    end

    def resource_params
      params.require(:problem).permit(:location_id, :status, :issued_at, :problem_category_id)
    end

  end
end
