class User < ActiveRecord::Base
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 12 }

	has_many :tasks

	def successful_tasks
		self.tasks.where(done_or_donated: "done")
	end

	def donated_tasks
		self.tasks.where(done_or_donated: "donated")
	end
end
