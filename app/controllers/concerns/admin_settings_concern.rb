module AdminSettingsConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:setting).permit(:index, :name, :value)
    end
  end
end
