module AdminLocationCategoriesConcern
  extend ActiveSupport::Concern
  included do

    def tree
      @resources = @model.where(ancestry: nil)
      if params[:category_id] == '0'
        @resources = @model.where(ancestry: nil)
      else
        @resources = @model.find(params[:category_id]).children
      end
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
