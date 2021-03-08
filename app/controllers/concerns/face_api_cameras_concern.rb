module FaceApiCamerasConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :rtsp, :status, :name, :enabled, :location_id])
    end

    def resource_params
      params.require(:camera).permit(:name, :rtsp, :status, :location_id)
    end

  end
end
