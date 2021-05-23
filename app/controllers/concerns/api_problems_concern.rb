module ApiProblemsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_status)
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :problem_status, :discover_type, :note, :issued_at, :created_at],
                       include: { location: { include: { path: { only: [:id, :name] } } },
                                  problem_category: { only: [:id, :name] },
                                  admin: { only: [:id, :full_name]},
                                  problem_evidences: { only: [:id, :created_at],
                                                       methods: [:img_data]},
                                  })
    end

    def resource_params
      params.require(:problem).permit(:location_id, :status, :issued_at, :problem_category_id)
    end

  end
end
