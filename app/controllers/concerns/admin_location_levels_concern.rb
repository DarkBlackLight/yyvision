module AdminLocationLevelsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def resource_params
      params.require(:location_level).permit(:name)
    end
  end
end
