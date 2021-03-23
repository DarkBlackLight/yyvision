class Admin::AdminsController < Admin::ResourcesController
  include AdminAdminsConcern

  def filter_params
    params.slice(:query_name, :query_role, :query_location_id)
  end

end

