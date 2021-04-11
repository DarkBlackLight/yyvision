class AddIfHolidayToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :if_holiday, :boolean, default: false
  end
end
