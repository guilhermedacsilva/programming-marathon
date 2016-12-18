class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    User.delete_all
    remove_index :users, column: :password
    remove_column :users, :password, :string
    add_column :users, :password_digest, :string
    change_column :users, :password_digest, :string, null: false
    add_index :users, :password_digest
  end
end
