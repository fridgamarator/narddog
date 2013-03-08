class Backup < ActiveRecord::Base
	include IceCube

	attr_accessible :last_performed, :schedule_time, :app_id, :cloudfile_container_id, :sftp_storage_id
	attr_accessor :date, :time

	# Validations

	# Associations
	belongs_to :app
	belongs_to :cloudfile_container
	belongs_to :sftp_storage

	# def schedule_time=(value)
	# 	write_attribute(:schedule_time, value.to_yaml)
	# end

	# def schedule_time
	# 	if read_attribute(:schedule_time)
	# 		Schedule.from_yaml(read_attribute(:schedule_time))
	# 	else
	# 		nil
	# 	end
	# end
end
