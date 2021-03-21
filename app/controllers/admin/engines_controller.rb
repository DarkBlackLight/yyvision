class Admin::EnginesController < Admin::ResourcesController
  include AdminEnginesConcern

  def filter_params
    params.slice(:query_name, :query_ip, :query_type)
  end

end

