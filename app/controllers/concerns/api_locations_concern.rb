module ApiLocationsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice()
    end

    def set_show_json(resource)
      resource.as_json(only: [:name, :id, :ancestry],
                       include: { parent: { only: [:id, :name] },},
                       include: { location_level: { only: [:id, :name, :index] },},
                       )
    end

    def resource_params
      params.require(:location).permit(:lat, :lon, :name, :parent_id, :engine_id, :location_level_id, :location_category_id, setting_event_ids: [])
    end

  end
end
