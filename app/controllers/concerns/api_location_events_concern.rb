module ApiLocationEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :event_id, :problem_id, :active, :length, :active_at, :created_at],
                       include: {
                         event: { only: [:id, :name] },
                         location: { only: [:id, :name], include: { path: { only: [:id, :name] } } },
                         master_camera_capture: { only: [:id], methods: :img_data }
                       },
                       methods: [:camera_capture_ids])
    end

    def resource_params
      params.require(:location_event).permit(:event_id, :problem_id, :location_id, :active, :active_at, :length, :created_at, camera_capture_ids: [])
    end

  end
end
