class CreateLocationEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :location_events do |t|
      t.integer :location_id
      t.integer :event_id

      t.datetime :active_at
      t.integer :problem_id
      t.timestamps
    end

    add_index :location_events, :location_id
    add_index :location_events, :event_id
  end
end
