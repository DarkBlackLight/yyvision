module AdminCamerasConcern
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
            location = Location.find_by_name(row[1].to_s)
            Camera.find_or_create_by!(name: row[0].to_s, location: location, rtsp: row[2].to_s)
          end
        end

        render json: { data: url_for({ action: :index }) }, status: :ok
      rescue => e
        render json: { data: "At Row #{current_row.to_s}. #{e}" }, status: :unprocessable_entity
      end

    end

    private

    def filter_params
      params.slice(:query_name, :query_state, :query_location)
    end

    def resource_params
      params.require(:camera).permit(:name, :rtsp, :status, :enabled, :location_id,
                                     event_cameras_attributes: [:box_a, :box_b, :box_c, :box_d, :line_a, :line_b])
    end
  end
end
