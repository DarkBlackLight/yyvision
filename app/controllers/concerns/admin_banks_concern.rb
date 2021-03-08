module AdminBanksConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:bank).permit(:name, :parent_id, :index)
    end
  end
end
