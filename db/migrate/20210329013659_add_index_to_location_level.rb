class AddIndexToLocationLevel < ActiveRecord::Migration[6.1]
  def change
    add_column :location_levels, :index, :integer
  end
end
