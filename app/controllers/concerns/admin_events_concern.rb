module AdminEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:event).permit(:observation, :name, :nickname, :notify, :interval, :tolerance, :problem_tolerance, :problem_category_id, event_time_ranges_attributes: [:id, :start_time, :end_time, :_destroy])
    end
  end
end
