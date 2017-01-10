class CreateMarathons < ActiveRecord::Migration
  def change
    create_table :marathons do |t|
      t.string :name, null: false
      t.boolean :started, null: false, default: false

      t.timestamps null: false
    end
  end
end
