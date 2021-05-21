module ApiAdminsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :full_name, :role], include: { location: { only: [:id, :name] } })
    end

    def resource_params
      params.require(:admin).permit(:name)
    end

  end
end
