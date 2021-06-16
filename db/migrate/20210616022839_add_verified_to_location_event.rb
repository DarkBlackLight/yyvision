class AddVerifiedToLocationEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :location_events, :verified, :boolean, default: false
  end
end
