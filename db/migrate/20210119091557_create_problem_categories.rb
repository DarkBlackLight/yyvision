class CreateProblemCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :problem_categories do |t|
      t.integer :parent_id
      t.integer :level, default: 1

      t.string :name
      t.timestamps
    end
  end
end
