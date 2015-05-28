class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :bounty, presence: true

	belongs_to :user


	def time_left
		time_in_secs = self.due_date - Time.now
		Utils.seconds_to_string(time_in_secs)
	end
end
