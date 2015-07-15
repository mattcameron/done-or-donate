class Charge < ActiveRecord::Base
	validates :task_id, presence: true
	validates :total_cents, presence: true

	belongs_to :task
end