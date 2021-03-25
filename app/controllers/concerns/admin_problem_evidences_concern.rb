module AdminProblemEvidencesConcern
  extend ActiveSupport::Concern
  included do
    private

    def filter_params
      params.slice(:query_name)
    end

    def resource_params
      params.require(:problem_evidence).permit(:problem_id, :img)
    end

  end
end
