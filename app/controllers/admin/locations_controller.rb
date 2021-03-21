class Admin::LocationsController < Admin::ResourcesController
  include AdminLocationsConcern

  def filter_params
    params.slice(:query_name, :query_parent)
  end

end

