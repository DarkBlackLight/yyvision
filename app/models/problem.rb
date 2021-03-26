class Problem < ApplicationRecord
  scope :query_problem_category_id, -> (q) { where(problem_category_id: q) }

  belongs_to :problem_category, optional: true
  belongs_to :admin

  has_many :problem_evidences, dependent: :destroy

  before_validation :setup_issued_at

  def setup_issued_at
    self.issued_at = Time.zone.now unless self.issued_at
  end

  enum discover_type: [:vision, :search, :manual, :other]
  enum problem_status: [:waiting, :correcting, :corrected, :invalid, :reviewing]

end
