class Problem < ApplicationRecord
  belongs_to :problem_category
  belongs_to :admin
  scope :query_problem_category_id, -> (q) { where(problem_category_id: q) }

  before_validation :setup_issued_at

  def setup_issued_at
    self.issued_at = Time.zone.now unless self.issued_at
  end
end
