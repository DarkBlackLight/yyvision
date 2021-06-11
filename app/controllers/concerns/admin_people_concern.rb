module AdminPeopleConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def resource_params
      params.require(:person).permit(:name, portraits_attributes: [:id, :index, :_destroy], bank_ids: [])
    end
  end
end
