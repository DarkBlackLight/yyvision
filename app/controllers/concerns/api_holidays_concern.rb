module ApiHolidaysConcern
  extend ActiveSupport::Concern
  included do

    private

    def filter_params
      params.slice()
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :off_date])
    end

  end
end
