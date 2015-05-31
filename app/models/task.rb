class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :bounty, presence: true

	belongs_to :user


	def time_left
		return "Finished" if self.completed || self.past_due_date?

		time_in_secs = self.due_date - Time.zone.now
		Utils.seconds_to_string(time_in_secs)
	end

	def past_due_date?
		self.due_date < Time.zone.now
	end
end
