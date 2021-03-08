module AdminPeopleConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:person).permit(:name, portraits_attributes: [:id, :index, :img, :_destroy], bank_ids: [])
    end
  end
end
