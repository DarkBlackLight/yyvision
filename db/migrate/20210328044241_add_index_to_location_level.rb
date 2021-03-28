class AddValidToLocationEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :location_levels, :index, :integer, default: true
  end
end
