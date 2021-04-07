class AddAncestryToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :ancestry, :string
    add_index :locations, :ancestry
  end
end
