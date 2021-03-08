class CreateCameraCaptures < ActiveRecord::Migration[6.1]
  def change
    create_table :camera_captures do |t|
      t.integer :camera_id
      t.integer :engine_id

      t.timestamps
    end

    add_index :camera_captures, :camera_id
    add_index :camera_captures, :engine_id
  end
end
