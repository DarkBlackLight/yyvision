class AddObservationToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :observation, :integer, default: 1
  end
end
