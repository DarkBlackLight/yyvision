module AdminEnginesConcern
  extend ActiveSupport::Concern
  require "base64"

  included do
    private

    def filter_params
      params.slice(:query_name, :query_ip, :query_type)
    end

    def resource_params
      params.require(:engine).permit(:full_name, :internal_address, :external_address, :workers, :engine_type, :device)
    end
  end
end
