module FaceApiLocationEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :event_id, :created_at], methods: [:camera_capture_ids])
    end

    def resource_params
      params.require(:location_event).permit(:event_id, :location_id, :created_at, camera_capture_ids: [])
    end

  end
end
