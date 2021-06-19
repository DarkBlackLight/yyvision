class LocationEvent < ApplicationRecord
  scope :query_location_id, -> (q) { where(location_id: q) }
  scope :query_event_id, -> (q) { where(event_id: q) }

  belongs_to :location
  belongs_to :event
  belongs_to :problem, optional: true
  belongs_to :master_camera_capture, class_name: 'CameraCapture', optional: true

  has_many :location_event_camera_captures, dependent: :destroy
  has_many :camera_captures, -> { order(created_at: :asc) }, through: :location_event_camera_captures

  before_save :setup_length

  after_commit :create_problem
  after_commit :setup_master_camera_capture
  after_create_commit :broadcast

  scope :query_event_id, -> (q) { joins(:event).where(:'event_id' => q) }
  scope :query_active, -> (q) { where active: q }
  scope :query_location_id_0, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_1, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_2, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_3, -> (q) { where(location_id: Location.find(q).subtree_ids) }
  scope :query_location_id_4, -> (q) { where(location_id: Location.find(q).subtree_ids) }

  def setup_length
    self.length = (self.active_at - self.created_at) / 1.minutes if self.active_at
  end

  def create_problem
    if_create_problem = !problem && active == true && self.length >= self.event.problem_tolerance && self.event.problem_category_id
    if_create_problem = if_create_problem && (ENV['NEED_LOCATION_EVENT_VERIFIED'] != '1' || self.verified)

    if if_create_problem

      dest_location = self.location.path.query_location_level_id(4).first

      self.problem = Problem.where(problem_category_id: self.event.problem_category_id,
                                   location: dest_location ? dest_location : self.location)
                            .query_from_date((self.created_at - self.event.interval.minutes).strftime('%F %T')).first

      self.problem = Problem.create(location: dest_location ? dest_location : self.location,
                                    problem_category_id: self.event.problem_category_id,
                                    issued_at: self.created_at, admin: Admin.first) unless self.problem

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

  def setup_master_camera_capture
    unless master_camera_capture
      self.update_column(:master_camera_capture_id, camera_captures.first.id) if camera_captures.first
    end
  end
end
