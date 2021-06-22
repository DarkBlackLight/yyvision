module ApiEventsConcern
  extend ActiveSupport::Concern
  included do
    private

    def set_index_json(resources)
      set_show_json(resources.includes(:event_time_ranges))
    end

    def set_show_json(resource)
      resource.as_json(only: [:observation, :id, :name, :notify, :if_holiday, :if_video, :nickname, :interval, :problem_tolerance, :problem_category_id, :tolerance, :confidence, :threshold],
                       include: { event_time_ranges: { only: [:id, :start_time, :end_time] } })
    end

  end
end
