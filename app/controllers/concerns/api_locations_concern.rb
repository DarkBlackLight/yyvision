module ApiLocationsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_physical, :query_location_level_name)
    end

    def index_json(resources)
      show_json(resources.includes([:event_locations, :cameras => :event_cameras]))
    end

    def show_json(resource)
      resource.as_json(only: [:id, :name], methods: [:setting_event_ids],
                       include: {
                         parent: { only: [:id, :name] },
                         location_level: { only: [:id, :name, :index] },
                         cameras: { only: [:id, :rtsp, :status, :name, :enabled, :location_id],
                                    include: { event_cameras: { only: [:event_id, :box_a, :box_b, :box_c, :box_d, :line_a, :line_b, :confidence, :threshold] } } },
                       })

    end

    def resource_params
      params.require(:location).permit(:lat, :lon, :name, :parent_id, :engine_id, :location_level_id, :location_category_id, setting_event_ids: [])
    end

  end
end
