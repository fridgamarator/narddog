class CloudfileContainer < ActiveRecord::Base
	attr_accessible :name

	# Validations
	validates :name, presence: true

	# Associations
end
