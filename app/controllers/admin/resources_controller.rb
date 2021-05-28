class Admin::ResourcesController < AdminController
  include ManageResourcesConcern

  private

  def index_order_by
    'created_at desc'
  end
end