class AddUserIdToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :user_id, :integer
    add_foreign_key :answers, :users
    add_index :answers, :user_id
  end
end
