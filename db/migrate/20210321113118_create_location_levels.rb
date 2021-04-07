class CreateLocationLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :location_levels do |t|
      t.string :name
      t.integer :index, default: 0
      t.timestamps
    end
  end
end
