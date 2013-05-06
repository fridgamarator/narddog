class Backup < ActiveRecord::Base
	include IceCube
	serialize :schedule_rule

	attr_accessible :last_performed, :schedule_rule, :schedule_time, :app_id, :cloudfile_container_id, :sftp_storage_id

	# Validations
	validates :app_id, presence: true

	# Associations
	belongs_to :app
	belongs_to :cloudfile_container
	belongs_to :sftp_storage

	def schedule_rule
		if read_attribute(:schedule_rule)
			Schedule.from_yaml(read_attribute(:schedule_rule))
		else
			nil
		end
	end
end
	