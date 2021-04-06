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
  scope :query_location_id_1, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_location_id_2, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_location_id_3, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_location_id_4, -> (q) { joins(:location).where(:'location_id' => q) }
  scope :query_location_id_5, -> (q) { joins(:location).where(:'location_id' => q) }

  def setup_length
    self.length = (self.active_at - self.created_at) / 1.minutes if self.active_at
  end

  def create_problem
    if !problem && self.length >= self.event.problem_tolerance
      self.problem = Problem.create(issued_at: self.created_at,
                                    location: self.location,
                                    problem_category_id: self.event.problem_category_id,
                                    admin: Admin.first)

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
                                                                   include: [location: { only: [:id, :name] },
                                                                             event: { only: [:id, :name] }]))
    end
  end

end
