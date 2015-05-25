class Task < ActiveRecord::Base
	validates :title, presence: true
	validates :due_date, presence: true
	validates :bounty, presence: true

	belongs_to :user
end
