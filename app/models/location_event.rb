class LocationEvent < ApplicationRecord
  scope :query_location_id, -> (q) { where(location_id: q) }
  scope :query_event_id, -> (q) { where(event_id: q) }

  belongs_to :location
  belongs_to :event
  belongs_to :problem, optional: true

  has_many :location_event_camera_captures, dependent: :destroy
  has_many :camera_captures, through: :location_event_camera_captures

  before_save :setup_length

  after_commit :create_problem
  after_create_commit :broadcast

  scope :query_event_id, -> (q) { joins(:event).where(:'event_id' => q) }
  scope :query_active, -> (q) { where active: q }
  scope :query_location_id_0, -> (q) { where(location_id: Location.find(q).subtree_ids )}
  scope :query_location_id_1, -> (q) { where(location_id: Location.find(q).subtree_ids )}
  scope :query_location_id_2, -> (q) { where(location_id: Location.find(q).subtree_ids )}
  scope :query_location_id_3, -> (q) { where(location_id: Location.find(q).subtree_ids )}
  scope :query_location_id_4, -> (q) { where(location_id: Location.find(q).subtree_ids )}

  def setup_length
    self.length = (self.active_at - self.created_at) / 1.minutes if self.active_at
  end

  def create_problem
    if !problem && self.length >= self.event.problem_tolerance

      self.problem = Problem.where(location: self.location,
                                   problem_category_id: self.event.problem_category_id,
                                   admin: Admin.first)
                            .query_from_date((self.created_at - self.event.interval.minutes).strftime('%F %T')).first

      self.problem = Problem.create(issued_at: self.created_at,
                                    location: self.location,
                                    problem_category_id: self.event.problem_category_id,
                                    admin: Admin.first) unless self.problem

      self.save

      self.camera_captures.each do |camera_capture|
        img_data = camera_capture.img_data[:src]

        if img_data
          problem_evidence = ProblemEvidence.create(problem: self.problem)
          filename = File.basename(URI.parse(img_data).path)
          file = URI.open(img_data)
          problem_evidence.img.attach(io: file, filename: filename)
        end
      end
    end
  end

  def broadcast
    if active
      ActionCable.server.broadcast("location_events", self.as_json(only: [:id, :created_at],
                                                                   include: [location: { only: [:id],
                                                                                         include: { path: { only: [:id, :name] } } },
                                                                             event: { only: [:id, :name] }]))
    end
  end

end
