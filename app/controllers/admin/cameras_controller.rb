class Admin::CamerasController < Admin::ResourcesController
  include AdminCamerasConcern

  def filter_params
    params.slice(:query_name, :query_state, :query_location)
  end

end

