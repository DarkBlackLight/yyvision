class AddDetailsToCameras < ActiveRecord::Migration[6.1]
  def change
    add_column :cameras, :marked, :boolean
  end
end
