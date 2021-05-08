module AdminHolidaysConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice(:query_created_at_from, :query_created_at_to)
    end

    def resource_params
      params.require(:holiday).permit(:off_date)
    end

  end
end
