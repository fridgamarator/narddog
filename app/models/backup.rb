class Backup < ActiveRecord::Base
	attr_accessible :last_performed, :schedule_time, :app_id, :cloudfile_container_id, :sftp_storage_id
	attr_accessor :date, :time

	# Validations

	# Associations
	belongs_to :app
	belongs_to :cloudfile_container
	belongs_to :sftp_storage
end
