class AddMarathonToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :marathon, index: true, foreign_key: true
  end
end
