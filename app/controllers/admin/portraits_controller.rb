class Admin::PortraitsController < Admin::ResourcesController
  include VisionConcern
  include AdminPortraitsConcern
end

