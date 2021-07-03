class RemoveSomeIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :portrait_searches, column: :portrait_id
    remove_index :portrait_search_results, column: :portrait_search_id
    remove_index :bodies, column: [:source_type, :source_id]
    remove_index :portraits, column: [:source_type, :source_id]
  end
end
