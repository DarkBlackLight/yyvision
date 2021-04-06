module AdminCamerasConcern
  extend ActiveSupport::Concern
  included do


    def stats_cameras_group_status
      render json: {online: Camera.accessible_by(current_ability, :read).filterable(filter_params).where(status: 'normal').size, offline: Camera.accessible_by(current_ability, :read).filterable(filter_params).where(status: 'offline').size}.as_json, status: :ok
    end


    def upload_excel
      require 'roo'
      xlsx = Roo::Spreadsheet.open(params[:file])
      sheet = xlsx.sheet(0)
      current_row = 1

      begin
        ActiveRecord::Base.transaction do
          sheet.each_row_streaming(offset: 1) do |row|
            current_row = current_row + 1

            location_parent = nil
            location_names = row[2].to_s.split('@')

            location_names.each do |location_name|
              location = Location.find_or_create_by!(name: location_name, parent: location_parent)
              location_parent = location
              setting_event_ids = []

              row[3].to_s.split(',').each do |event_name|
                event = Event.find_by_name(event_name.gsub(/\s+/, ""))
                setting_event_ids.append(event.id) if event
              end
              location.setting_event_ids = setting_event_ids
              location.save

              Camera.find_or_create_by!(name: row[0].to_s, location: location, rtsp: row[1].to_s)
            end
          end
        end

        render json: { data: url_for({ action: :index }) }, status: :ok
      rescue => e
        render json: { data: "At Row #{current_row.to_s}. #{e}" }, status: :unprocessable_entity
      end

    end

    private

    def filter_params
      params.slice(:query_name, :query_status, :query_location_id)
    end

    def resource_params
      params.require(:camera).permit(:query_event_id, :name, :rtsp, :status, :enabled, :location_id,
                                     event_cameras_attributes: [:box_a, :box_b, :box_c, :box_d, :line_a, :line_b])
    end
  end
end
