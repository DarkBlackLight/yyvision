class LocationEventCameraCapture < ApplicationRecord
  belongs_to :location_event
  belongs_to :camera_capture

  # validates :camera_capture_id, uniqueness: { scope: :location_event_id }

  after_commit :create_problem_evidence

  def create_problem_evidence
    if location_event.problem
      img_data = camera_capture.img_data[:src]
      if img_data
        problem_evidence = ProblemEvidence.create(problem: self.location_event.problem)
        filename = File.basename(URI.parse(img_data).path)
        file = URI.open(img_data)
        problem_evidence.img.attach(io: file, filename: filename)

        location_event.problem.update_column(:active_at, location_event.active_at)
      end
    end
  end

end
