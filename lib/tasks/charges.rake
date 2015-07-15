task :select_tasks => :environment do
	Task.unpaid_tasks.each do |task|

    charge = Charge.create(task_id: task.id, total_cents: task.bounty * 100)

    # create a payment and new Charge record
    payment = PinPayment::Charge.create(
      customer: task.user.customer_token,
      email: task.user.email,
      amount: charge.total_cents
      currency: 'AUD',                       # hardcoded for now
      description: "Done or Donate failed task",
      ip_address: task.user.ip_address
    )

    if payment.success?
      # update paid attribute on the Task
      task.update(paid: true)
      # and on the Charge
      charge.update(successful: true)
    end

    # else leave 'paid' and 'successful' as false
  end

end