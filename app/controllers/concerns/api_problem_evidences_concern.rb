module ApiProblemEvidencesConcern
  extend ActiveSupport::Concern
  included do
    private

    def resource_params
      params.require(:problem_evidence).permit(:problem_id, :img)
    end

  end
end
