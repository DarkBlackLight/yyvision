module AdminUploadsConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:upload).permit(:admin_id, :img)
    end
  end
end
