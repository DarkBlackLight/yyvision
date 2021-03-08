module AdminEnginesConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:engine).permit(:full_name, :address, :workers, :engine_type, :device, :page, :page_size)
    end
  end
end
