class CreateCameraCaptures < ActiveRecord::Migration[6.1]
  def change
    create_table :camera_captures do |t|
      t.integer :camera_id
      t.integer :location_id
      t.integer :engine_id

      t.string :img_url
      t.timestamps
    end

    add_index :camera_captures, :camera_id
    add_index :camera_captures, :location_id
    add_index :camera_captures, :engine_id
  end
end
