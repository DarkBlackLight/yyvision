module ApiEnginesConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice(:query_secret, :query_type)
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :full_name, :internal_address, :external_address, :cached, :workers, :engine_type, :device, :params, :secret])
    end

  end
end
