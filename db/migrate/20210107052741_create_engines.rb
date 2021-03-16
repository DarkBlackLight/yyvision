class CreateEngines < ActiveRecord::Migration[6.1]
  def change
    create_table :engines do |t|
      t.string :full_name
      t.string :secret

      t.string :address, default: '0.0.0.0:7998'
      t.string :workers, default: 1
      t.integer :engine_type, default: 0
      t.integer :device

      t.string :params, default: ''

      t.datetime :expired_at
      t.timestamps
    end
  end
end
