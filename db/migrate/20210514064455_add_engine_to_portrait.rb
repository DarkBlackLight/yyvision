class AddEngineToPortrait < ActiveRecord::Migration[6.1]
  def change
    add_column :portraits, :engine_id, :integer
  end
end
