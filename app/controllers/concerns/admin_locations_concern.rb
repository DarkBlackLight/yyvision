module AdminLocationsConcern
  extend ActiveSupport::Concern
  included do

    def upload_excel
      require 'roo'
      xlsx = Roo::Spreadsheet.open(params[:file])
      sheet = xlsx.sheet(0)
      current_row = 1

      begin
        ActiveRecord::Base.transaction do
          sheet.each_row_streaming(offset: 1) do |row|
            current_row = current_row + 1

            parent = Location.find_by_name(row[1].to_s)

            setting_event_ids = []

            if row[2].to_s
              row[2].to_s.split(',').each do |event_name|
                event = Event.find_by_name(event_name.gsub(/\s+/, ""))
                setting_event_ids.append(event.id) if event
              end
            end

            location = Location.find_or_create_by!(name: row[0].to_s, parent: parent)
            location.setting_event_ids = setting_event_ids
            location.save
          end
        end

        render json: { data: url_for({ action: :index }) }, status: :ok
      rescue => e
        render json: { data: "At Row #{current_row.to_s}. #{e}" }, status: :unprocessable_entity
      end

    end

    private

    def filter_params
      params.slice(:query_name, :query_parent_id)
    end

    def resource_params
      params.require(:location).permit(:lat, :lon, :name, :parent_id, :engine_id, :location_level_id, :location_category_id, setting_event_ids: [])
    end
  end
end
