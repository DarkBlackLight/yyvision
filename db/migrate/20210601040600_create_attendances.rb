class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.integer :person_id
      t.integer :portrait_id

      t.timestamps
    end
  end
end
