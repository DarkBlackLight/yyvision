class CreateProblems < ActiveRecord::Migration[6.1]
  def change
    create_table :problems do |t|
      t.integer :problem_category_id
      t.integer :admin_id
      t.string :note
      t.datetime :issued_at

      t.timestamps
    end
  end
end
