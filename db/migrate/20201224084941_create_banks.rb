class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.integer :parent_id
      t.integer :index

      t.timestamps
    end
  end
end
