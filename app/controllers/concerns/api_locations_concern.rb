module ApiLocationsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_physical)
    end

    def set_index_json(resources)
      set_show_json(resources.includes(:cameras, :event_locations))
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :name], methods: [:setting_event_ids],
                       include: { cameras: { only: [:id, :rtsp, :status, :name, :enabled, :location_id, :confidence],
                                             include: { event_cameras: { only: [:event_id, :box_a, :box_b, :box_c, :box_d, :line_a, :line_b] } } },
                       })
    end
  end
end
