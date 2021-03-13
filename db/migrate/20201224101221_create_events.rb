class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :nickname

      t.boolean :enabled, default: true
      t.boolean :notify, default: true

      t.float :confidence, default: 0.6

      t.float :tolerance, default: 10
      t.float :interval, default: 10

      t.timestamps
    end
  end
end
