class Problem < ApplicationRecord
  scope :query_problem_category_id, -> (q) { where(problem_category_id: q) }
  scope :query_discover_type, -> (q) { where(discover_type: q) }
  scope :query_problem_status, -> (q) { where(problem_status: q) }
  scope :query_from_date, -> (q) { where(issued_at: Time.zone.parse(q)..) }
  scope :query_to_date, -> (q) { where(issued_at: ..Time.zone.parse(q)) }
  scope :query_admin_id, -> (q) { where(admin_id: q) }

  belongs_to :problem_category, optional: true
  belongs_to :admin
  belongs_to :location

  has_many :problem_evidences, dependent: :destroy
  accepts_nested_attributes_for :problem_evidences, allow_destroy: true

  has_many :problem_corrections, dependent: :destroy
  accepts_nested_attributes_for :problem_corrections, allow_destroy: true

  before_validation :setup_issued_at

  def setup_issued_at
    self.issued_at = Time.zone.now unless self.issued_at
  end

  enum discover_type: [:vision, :search, :manual, :other]
  enum problem_status: [:waiting, :correcting, :corrected, :negate, :reviewing]

end
