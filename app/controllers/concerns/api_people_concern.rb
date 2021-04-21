module ApiPeopleConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name, :query_bank_id)
    end

    def set_show_json(resource)
      resource.as_json(only: [:id, :name, :bank_id], include: [portraits: { only: [], methods: [:img_data] }])
    end

    def resource_params
      params.require(:person).permit(:name, portraits_attributes: [:id, :index, :img, :_destroy], bank_ids: [])
    end
  end
end
