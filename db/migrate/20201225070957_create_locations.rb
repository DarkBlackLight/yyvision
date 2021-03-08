class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.integer :parent_id

      t.boolean :physical, default: false
      t.string :name

      t.timestamps
    end
  end
end
