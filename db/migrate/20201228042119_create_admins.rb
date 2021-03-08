class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :full_name
      t.integer :role

      t.integer :location_id
      t.timestamps
    end
  end
end
