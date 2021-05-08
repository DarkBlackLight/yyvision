module AdminNotificationsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name, :query_created_at_from, :query_created_at_to, :query_admin_id)
    end

    def resource_params
      params.require(:notification).permit(:name, :description, :admin_id, notification_attachments_attributes: [:id, :_destroy])
    end

  end
end
