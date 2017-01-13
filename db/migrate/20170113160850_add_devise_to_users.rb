class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, column: :password_digest
    remove_column :users, :password_digest
    remove_column :users, :remember_digest
    remove_column :users, :access

    change_table :users do |t|
      t.integer :access, null: false, default: 0

      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ''

      ## Rememberable
      t.datetime :remember_created_at
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
