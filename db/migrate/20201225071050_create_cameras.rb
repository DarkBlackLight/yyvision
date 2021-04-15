class CreateCameras < ActiveRecord::Migration[6.1]
  def change
    create_table :cameras do |t|
      t.string :name
      t.string :rtsp
      t.integer :status, default: 0

      t.integer :master_camera_capture_id
      t.integer :location_id

      t.boolean :marked, default: false

      t.timestamps
    end

    add_index :cameras, :location_id
  end
end
