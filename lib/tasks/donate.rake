task :select_tasks => :environment do
	Task.unpaid_tasks.each do
		# create a charge
		# if successful, update paid attribute
	end

end