class CloudfileContainer < ActiveRecord::Base
	attr_accessible :name, :api_key, :username

	# Validations
	validates :name, presence: true

	# Associations
	has_many :apps, dependent: :nullify
	has_many :backups, dependent: :nullify
end
