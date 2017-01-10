class AddRegistrationToMarathons < ActiveRecord::Migration
  def change
    add_column :marathons, :registration, :boolean, default: false
  end
end
