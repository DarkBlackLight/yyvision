class ApplicationRecord < ActiveRecord::Base
  include Filterable
  include VisionConcern
  include Rails.application.routes.url_helpers
  self.abstract_class = true

  scope :query_created_at_from, -> (q) { where(created_at: (Time.zone.parse(q)..Time.zone.now)) }
  scope :query_created_at_to, -> (q) { where(created_at: (Time.zone.now..Time.zone.parse(q))) }
end
