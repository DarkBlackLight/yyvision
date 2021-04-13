class AddDetailsToProblems < ActiveRecord::Migration[6.1]
  def change
    add_column :problems, :reviewing_admin, :string
    add_column :problems, :reviewing_at, :datetime
    add_column :problems, :reviewing_note, :string
  end
end
