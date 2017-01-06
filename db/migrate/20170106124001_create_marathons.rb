class CreateMarathons < ActiveRecord::Migration
  def change
    create_table :marathons do |t|
      t.string :name, null: false
      t.boolean :open, null: false

      t.timestamps null: false
    end
  end
end
