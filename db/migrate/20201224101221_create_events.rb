class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :nickname

      t.boolean :enabled, default: true
      t.boolean :notify, default: true

      t.float :confidence, default: 0.75

      t.float :tolerance, default: 5
      t.float :interval, default: 10

      t.float :problem_tolerance, default: 15
      t.integer :problem_category_id
      t.integer :observation, default: 1
      t.boolean :if_holiday, default: false
      t.timestamps
    end
  end
end
