class Admin::EventsController < Admin::ResourcesController
  include AdminEventsConcern

  def filter_params
    params.slice(:query_name, :query_enabled)
  end

end

