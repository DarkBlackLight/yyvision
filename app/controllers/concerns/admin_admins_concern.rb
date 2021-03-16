module AdminAdminsConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:admin).permit(:full_name, :location_id, :role, user_attributes: [:full_name, :username, :password, :password_confirmation])
    end
  end
end
