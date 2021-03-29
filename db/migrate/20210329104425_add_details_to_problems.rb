class AddDetailsToProblems < ActiveRecord::Migration[6.1]
  def change
    add_column :problems, :correction_user, :string
    add_column :problems, :correction_time, :datetime
    add_column :problems, :correction, :string
    add_column :problems, :invalidp_user, :string
    add_column :problems, :invalidp, :string
    add_column :problems, :invalidp_time, :datetime
  end
end
