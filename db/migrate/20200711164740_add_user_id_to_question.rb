class AddUserIdToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :user_id, :integer
    add_foreign_key :questions, :users, on_delete: :cascade
    add_index :questions, :user_id
  end
end
