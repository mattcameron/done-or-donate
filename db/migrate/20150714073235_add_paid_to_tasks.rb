class AddPaidToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :paid, :boolean, default: false
  end
end
