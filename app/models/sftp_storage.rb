class SftpStorage < ActiveRecord::Base
	attr_accessible :name, :server_ip, :server_password, :server_path, :server_username

	# Validations
	validates :name, presence: true
	validates :server_ip, presence: true
	validates :server_path, presence: true
	validates :server_username, presence: true

	# Associations
end
