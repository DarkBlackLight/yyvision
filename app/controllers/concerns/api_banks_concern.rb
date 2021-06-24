module ApiBanksConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name, :query_ancestry)
    end

    def show_json(resource)
      resource.as_json(only: [:id, :index, :name, :ancestry])
    end

    def resource_params
      params.require(:bank).permit(:index, :name, :ancestry)
    end

  end
end
