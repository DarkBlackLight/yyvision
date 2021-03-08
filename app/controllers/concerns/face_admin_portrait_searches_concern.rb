module FaceAdminPortraitSearchesConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:portrait_search).permit(:portrait_id, :admin_id, :source_type)
    end
  end
end
