class AddValidToLocationEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :location_events, :active, :boolean, default: true
  end
end
