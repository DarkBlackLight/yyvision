module AdminPeopleConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def create_success_path
      url_for({ action: :edit, id: @resource.id })
    end

    def resource_params
      params.require(:person).permit(:name, portraits_attributes: [:id, :index, :_destroy], bank_ids: [])
    end
  end
end
