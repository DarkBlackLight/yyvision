module AdminEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:event).permit(:name, :nickname, :notify, :interval, :tolerance, event_time_ranges_attributes: [:id, :start_time, :end_time, :_destroy])
    end
  end
end
