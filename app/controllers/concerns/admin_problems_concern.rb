module AdminProblemsConcern
  extend ActiveSupport::Concern
  included do

    def stats_problem_map_modal
      @resources  = Problem.joins(:location).where(locations: {name: params[:name]})
      render 'admin/dashboard/map_problem_module', layout: false
    end

    def stats_problem_group_type
      @data = Problem.accessible_by(current_ability, :read).filterable(filter_params).group(:problem_status).count
      @result = {}
      Problem.problem_statuses.keys.each_with_index do |status|
        @result[(t "activerecord.attributes.problem.problem_status.#{status}")] = @data[status] ? @data[status] : 0
      end
      render json: { data: @result }
    end

    def stats_problem_group_division
      @division_id = @current_admin_user.source.location ? @current_admin_user.source.location.id : 1
      @division_id_arr = Location.where(parent_id: @division_id)
      @result = {}
      @division_id_arr.each_with_index do |status|
        @result[status.name] = Problem.accessible_by(current_ability, :read).filterable(filter_params).where(location_id: status.id).count
      end
      render json: { data: @result }
    end

    def stats_problem_group_map
      @division_id = @current_admin_user.source.location ? @current_admin_user.source.location.id : 1
      @division_id_arr = Location.where(parent_id: @division_id)
      @result = {}
      @division_id_arr.each_with_index do |status|
        @result[status.name] = Problem.accessible_by(current_ability, :read).filterable(filter_params).where(location_id: status.id).count
      end
      render json: { data: @result }
    end

    def report_problems
      @resources_all = @model.accessible_by(current_ability, :read).filterable(filter_params)
      render 'admin/problems/report_problems', layout: false
    end

    def report_generation_0
      @resources = @model.accessible_by(current_ability, :read).filterable(filter_params)
      respond_to do |format|
        format.docx { headers["Content-Disposition"] = "attachment; filename=\"研判报告.docx\"" }
      end


    end

    def report_generation_1
      respond_to do |format|
        format.docx { headers["Content-Disposition"] = "attachment; filename=\"#{'巡查报告'}.docx\"" }
      end
    end

    private

    def filter_params
      params.slice(:query_problem_category_id, :query_from_date, :query_to_date, :query_admin_id)
    end

    def resource_params
      params.require(:problem).permit(:problem_status, :problem_category_id, :issued_at, :note, :admin_id, :location_id,
                                      problem_evidences_attributes: [:id, :_destroy])
    end
  end
end
