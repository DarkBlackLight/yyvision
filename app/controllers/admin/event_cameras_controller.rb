class Admin::EventCamerasController < Admin::ResourcesController
  include AdminEventCamerasConcern

  def edit
    render 'admin/event_cameras/edit', layout: false
  end
end

