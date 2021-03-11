module AdminEnginesConcern
  extend ActiveSupport::Concern
  require "base64"

  included do
    private

    def resource_params
      params.require(:engine).permit(:full_name, :address, :workers, :engine_type, :device)
    end
  end
end
