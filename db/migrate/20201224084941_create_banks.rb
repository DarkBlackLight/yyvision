class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.integer :index

      t.string :ancestry
      t.timestamps
    end

    add_index :locations, :ancestry
  end
end
