module AdminEnginesConcern
  extend ActiveSupport::Concern
  included do
    private

    def index
      require "base64"
      super
    end

    def resource_params
      params.require(:engine).permit(:full_name, :address, :workers, :engine_type, :device)
    end
  end
end
