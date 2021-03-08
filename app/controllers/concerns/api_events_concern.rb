module ApiEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_show_json(resource)
      resource.as_json(only: [:id, :name, :nickname, :interval, :tolerance, :confidence],
                       include: { event_time_ranges: { only: [:id, :start_time, :end_time] } })
    end

  end
end
