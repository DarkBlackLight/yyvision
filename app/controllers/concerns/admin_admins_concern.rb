module AdminAdminsConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name, :query_role, :query_location_id)
    end

    def resource_params
      params.require(:admin).permit(:id, :full_name, :location_id, :role, user_attributes: [:id, :full_name, :username, :password, :password_confirmation])
    end
  end
end
