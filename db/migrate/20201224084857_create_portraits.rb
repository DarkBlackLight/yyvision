class CreatePortraits < ActiveRecord::Migration[6.1]
  def change
    create_table :portraits do |t|
      t.references :source, polymorphic: true

      t.integer :target_id
      t.float :target_confidence

      t.integer :index
      t.text :features

      t.string :box
      t.float :confidence

      t.string :left_eye
      t.string :right_eye
      t.string :nose
      t.string :left_mouth
      t.string :right_mouth

      t.timestamps
    end

    add_index :portraits, [:source_type, :source_id]
  end
end
