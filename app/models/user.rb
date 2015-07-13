class User < ActiveRecord::Base
	has_secure_password
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true, length: { minimum: 12 }

	has_many :tasks
end
