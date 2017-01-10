class AddSoftDeleteToMarathons < ActiveRecord::Migration
  def change
    add_column :marathons, :deleted_at, :datetime
  end
end
