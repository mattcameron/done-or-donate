task :update_tasks => :environment do

  Task.update_all_tasks

end