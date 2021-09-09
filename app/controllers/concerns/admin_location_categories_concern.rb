module AdminLocationCategoriesConcern
  extend ActiveSupport::Concern
  included do

    def tree
      @resource = @model.find(params[:id])
      @resources = @resource.children
      render 'admin/location_categories/tree', layout: false
    end

    private

    def filter_params
      params.slice(:query_name,  :query_level, :query_parent)
    end


    def resource_params
      params.require(:location_category).permit(:name, :parent_id, :index)
    end
  end
end
