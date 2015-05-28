class AddResultToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :done_or_donated, :string

  	change_column :tasks, :completed, 'boolean USING CAST(completed AS boolean)'
  end
end
