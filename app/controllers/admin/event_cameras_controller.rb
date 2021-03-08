class Admin::EventCamerasController < Admin::ResourcesController
  include FaceAdminEventCamerasConcern

  def edit
    render 'admin/event_cameras/edit', layout: false
  end
end

