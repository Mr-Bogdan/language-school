class AddUserIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :user_id, :integer
  end
  add_index :books, :user_id
end
