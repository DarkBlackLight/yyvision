class ApplicationRecord < ActiveRecord::Base
  include Filterable
  include VisionConcern
  include Rails.application.routes.url_helpers
  self.abstract_class = true
end
