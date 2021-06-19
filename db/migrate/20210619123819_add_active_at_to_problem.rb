class AddActiveAtToProblem < ActiveRecord::Migration[6.1]
  def change
    add_column :problems, :active_at, :datetime
  end
end
