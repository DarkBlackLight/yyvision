module AdminBanksConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def resource_params
      params.require(:bank).permit(:name, :parent_id, :index, :if_red, :if_black)
    end
  end
end
