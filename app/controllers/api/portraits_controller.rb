class Api::PortraitsController < Api::ResourcesController
  include VisionConcern
  include ApiPortraitsConcern
end
