module AdminNotificationsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice()
    end

    def resource_params
      params.require(:notification).permit(:name, :description, :admin_id)
    end

  end
end
