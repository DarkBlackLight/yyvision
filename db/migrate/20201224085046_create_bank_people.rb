class CreateBankPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_people do |t|
      t.integer :bank_id
      t.integer :person_id

      t.timestamps
    end

    add_index :bank_people, :bank_id
    add_index :bank_people, :person_id
  end
end
