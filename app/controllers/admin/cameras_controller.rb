class Admin::CamerasController < Admin::ResourcesController
  include AdminCamerasConcern
  
  def filter_params
    params.slice(:query_name, :query_status, :query_location_id)
  end

end

