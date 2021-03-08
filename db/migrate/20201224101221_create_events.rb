class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :nickname

      t.boolean :enabled, default: true
      t.float :confidence, default: 0.6
      t.integer :tolerance, default: 10
      t.integer :interval, default: 10

      t.timestamps
    end
  end
end
