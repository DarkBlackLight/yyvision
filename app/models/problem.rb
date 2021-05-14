class Problem < ApplicationRecord
  scope :query_problem_category_id, -> (q) { where(problem_category_id: q) }
  scope :query_discover_type, -> (q) { where(discover_type: q) }
  scope :query_problem_status, -> (q) { where(problem_status: q) }
  scope :query_from_date, -> (q) { where(issued_at: Time.zone.parse(q)..) }
  scope :query_to_date, -> (q) { where(issued_at: ..Time.zone.parse(q)) }
  scope :query_admin_id, -> (q) { where(admin_id: q) }
  scope :query_location_id_1, -> (q) { joins(:location).where(:'location_id' => Location.find(q).subtree_ids) }
  scope :query_location_id_2, -> (q) { joins(:location).where(:'location_id' => Location.find(q).subtree_ids) }
  scope :query_location_id_3, -> (q) { joins(:location).where(:'location_id' => Location.find(q).subtree_ids) }
  scope :query_location_id_4, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_location_id_5, -> (q) { joins(:location).where(:'location_id' => Location.find(q).parent.id) }

  belongs_to :problem_category, optional: true
  belongs_to :admin
  belongs_to :location

  has_many :location_events

  has_many :problem_evidences, dependent: :destroy
  accepts_nested_attributes_for :problem_evidences, allow_destroy: true

  has_many :problem_corrections, dependent: :destroy
  accepts_nested_attributes_for :problem_corrections, allow_destroy: true

  before_validation :setup_issued_at

  after_create_commit :broadcast

  def setup_issued_at
    self.issued_at = Time.zone.now unless self.issued_at
  end

  enum discover_type: [:vision, :search, :manual, :other]
  enum problem_status: [:waiting, :correcting, :corrected, :negated, :reviewing]

  def broadcast
    if self.vision?
      ActionCable.server.broadcast("problems", self.as_json(only: [:id, :created_at],
                                                            include: [location: { only: [:id],
                                                                                  include: { path: { only: [:id, :name] } } },
                                                                      problem_category: { only: [:id, :name] }]))
    end
  end

end
