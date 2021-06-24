module ApiHolidaysConcern
  extend ActiveSupport::Concern
  included do

    private

    def show_json(resource)
      resource.as_json(only: [:id, :off_date])
    end

  end
end
