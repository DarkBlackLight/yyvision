module ApiBanksConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :index, :name, :ancestry])
    end

    def resource_params
      params.require(:bank).permit(:index, :name, :ancestry)
    end

  end
end
