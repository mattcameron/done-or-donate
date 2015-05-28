class AddCompletedColumnToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :completed, :string

  	change_column :tasks, :bounty, :integer

  	Task.all.each do |task|
  		task.bounty = task.bounty.floor
  		task.save
  	end
  end
end
