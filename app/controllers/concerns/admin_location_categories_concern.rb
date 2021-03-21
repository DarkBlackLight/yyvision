module AdminLocationCategoriesConcern
  extend ActiveSupport::Concern
  included do
    private


    def resource_params
      params.require(:location_category).permit(:name, :parent_id, :index)
    end
  end
end
