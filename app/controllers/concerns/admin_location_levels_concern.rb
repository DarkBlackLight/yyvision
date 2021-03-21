module AdminLocationLevelsConcern
  extend ActiveSupport::Concern
  included do
    private


    def resource_params
      params.require(:location_levels).permit(:name,)
    end
  end
end
