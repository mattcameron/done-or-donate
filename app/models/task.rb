class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :bounty, presence: true

	belongs_to :user


	def time_left
		return "Completed" if self.completed
		return "Over" if self.past_due_date?

		time_in_secs = self.due_date - Time.now
		Utils.seconds_to_string(time_in_secs)
	end

	def past_due_date?
		self.due_date < Time.now
	end
end
