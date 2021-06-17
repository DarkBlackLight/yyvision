class AddCameraTypeToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :camera_type, :integer
  end
end
