class Admin::SessionsController < Manage::SessionsController
  layout 'manage/application'

  protected

  def setup_config
    @authentication_key = 'username'
  end

end
