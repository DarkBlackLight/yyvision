module AdminHolidaysConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice()
    end

    def resource_params
      params.require(:holiday).permit(:off_date)
    end

  end
end
