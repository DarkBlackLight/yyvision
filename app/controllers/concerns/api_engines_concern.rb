module ApiEnginesConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice(:query_secret)
    end

    def set_index_json(resources)
      set_show_json(resources.includes(:event_time_ranges))
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :full_name, :address, :workers, :engine_type, :device, :params, :secret])
    end

  end
end
