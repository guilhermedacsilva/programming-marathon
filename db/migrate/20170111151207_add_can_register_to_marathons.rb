class AddCanRegisterToMarathons < ActiveRecord::Migration
  def change
    add_column :marathons, :can_register, :boolean, default: false
  end
end
