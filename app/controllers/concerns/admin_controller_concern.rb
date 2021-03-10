module AdminControllerConcern
  extend ActiveSupport::Concern
  included do
    before_action :authenticate_admin_user!
    before_action :authenticate_admin_type

    include AdminHelper
    include ManageControllerConcern

    def authenticate_admin_type
      unless current_admin_user.source_type == 'Admin'
        sign_out(:admin_user)
        redirect_to new_admin_user_session_path
      end
    end

    def current_ability
      @current_ability ||= Ability::AdminAbility.new(current_admin_user)
    end

    def setup_routes
      @routes = [

      ]
    end
  end
end

