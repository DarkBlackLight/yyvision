class AddProblemDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :problems, :problem_status, :integer, default: 0
    add_column :problems, :location_id, :integer, default: 0
  end
end
