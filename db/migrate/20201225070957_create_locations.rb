class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.integer :parent_id

      t.boolean :physical, default: false
      t.string :name

      t.integer :engine_id
      t.timestamps

      t.integer :location_category_id
      t.integer :location_level_id
    end

    add_index :locations, :engine_id
  end
end
