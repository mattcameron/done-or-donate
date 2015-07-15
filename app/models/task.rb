class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :bounty, presence: true

	belongs_to :user
	has_many :charges


	def time_left
		return "Finished" if self.completed || self.past_due_date?

		time_in_secs = self.due_date - Time.zone.now
		Utils.seconds_to_string(time_in_secs)
	end

	def past_due_date?
		self.due_date < Time.zone.now
	end

	def update_finished_task
		if self.past_due_date? && self.completed != true
			self.completed = true
			self.done_or_donated = "donated"
			self.save
		end
	end

	def self.unpaid_tasks
		self.where("completed = ? AND done_or_donated = ? AND paid != ?", true, "donated", true)
	end
end
