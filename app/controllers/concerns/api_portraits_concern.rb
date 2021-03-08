module ApiPortraitsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_source_type)
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :features])
    end
  end
end
