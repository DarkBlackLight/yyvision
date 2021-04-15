module ApiBanksConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :index, :name, :parent_id])
    end

    def resource_params
      params.require(:bank).permit(:index, :name, :parent_id)
    end

  end
end
