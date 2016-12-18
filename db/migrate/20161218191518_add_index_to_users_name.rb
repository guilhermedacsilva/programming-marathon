class AddIndexToUsersName < ActiveRecord::Migration
  def change
    add_index :users, :name, unique: true
    add_index :users, :password
  end
end
