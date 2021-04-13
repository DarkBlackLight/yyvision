module AdminNotificationAttachmentsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice()
    end

    def resource_params
      params.require(:notification_attachment).permit(:notification_id, :file)
    end

  end
end
