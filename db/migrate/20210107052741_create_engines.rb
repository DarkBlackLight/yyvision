class CreateEngines < ActiveRecord::Migration[6.1]
  def change
    create_table :engines do |t|
      t.string :full_name
      t.string :secret

      t.string :address, default: '0.0.0.0:7998'
      t.string :workers, default: 1
      t.integer :engine_type, default: 0
      t.integer :device

      t.integer :page, default: 1
      t.integer :page_size, default: 100

      t.timestamps
    end
  end
end
