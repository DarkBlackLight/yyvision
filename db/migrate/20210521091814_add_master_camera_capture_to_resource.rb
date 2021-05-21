class AddMasterCameraCaptureToResource < ActiveRecord::Migration[6.1]
  def change
    add_column :problems, :master_camera_capture_id, :integer
    add_column :location_events, :master_camera_capture_id, :integer
  end
end
