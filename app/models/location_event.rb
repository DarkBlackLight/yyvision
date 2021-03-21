class LocationEvent < ApplicationRecord
  scope :query_location_id, -> (q) { where(location_id: q) }
  scope :query_event_id, -> (q) { where(event_id: q) }

  belongs_to :location
  belongs_to :event
  belongs_to :problem, optional: true

  has_many :location_event_camera_captures, dependent: :destroy
  has_many :camera_captures, through: :location_event_camera_captures

  after_commit :create_problem
  after_commit :broadcast

  def create_problem
    if !problem && self.created_at - Time.zone.now > (self.event.problem_tolerance).minutes
      self.problem = Problem.create(issued_at: self.created_at,
                                    problem_category_id: self.event.problem_category_id,
                                    admin: Admin.first)

      self.camera_captures.each do |camera_capture|
        img_data = camera_capture.img_url
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
    ActionCable.server.broadcast("location_events", self.as_json(only: [:id, :created_at],
                                                                 include: [location: { only: [:id, :name] },
                                                                           event: { only: [:id, :name] }]))
  end

end
