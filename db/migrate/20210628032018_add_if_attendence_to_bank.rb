class AddIfAttendenceToBank < ActiveRecord::Migration[6.1]
  def change
    add_column :banks, :if_attendance, :boolean, default: false
    add_column :people, :if_attendance, :boolean, default: false
  end
end
