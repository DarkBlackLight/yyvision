class CreateCameras < ActiveRecord::Migration[6.1]
  def change
    create_table :cameras do |t|
      t.string :name
      t.string :rtsp
      t.integer :status

      t.integer :master_camera_capture_id
      t.integer :location_id

      t.timestamps
    end

    add_index :cameras, :location_id
  end
end
