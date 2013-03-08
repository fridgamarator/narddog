module RunBackups

	# run the backup remotely
	def self.run_backup(backup)
		require 'net/sftp'
		require 'net/ssh'

		# get the tamplate string to write to file
		backup_template = self.backup_template(backup)
		config_template = self.backup_config_template
		
		# start sftp connection
		Net::SFTP.start(backup.app.server_ip, backup.app.server_username) do |sftp|

			# write template file to /app_path/backup_tmp.rb
			sftp.file.open("#{backup.app.server_path}/backup_tmp.rb", "w"){|f| f.puts backup_template }
			sftp.file.open("#{backup.app.server_path}/backup_config.rb", "w"){|f| f.puts backup_template }

			Net::SSH.start(backup.app.server_ip, backup.app.server_username) do |ssh|
				output = ssh.exec!("source ~/.bash_profile; cd #{backup.app.server_path}; backup perform -t temp_backup -c backup_config.rb")
			end

			sftp.remove("#{backup.app.server_path}/backup_tmp.rb")
			sftp.remove("#{backup.app.server_path}/backup_config.rb")

		end
	end

	private

	def self.backup_config_template
		config = "Dir[File.join(File.dirname(Config.config_file), \"backup_tmp.rb\")].each do |model|\n"
		config += "instance_eval(File.read(model))\n"
		config += "end"
	end

	# creates the backup config file(s)
	def self.backup_template(backup)
		template = ""
		template += "Backup::Model.new(:temp_backup, 'NardDog backup template') do\n"
		template += "split_into_chunks_of 250\n"
		if backup.cloudfile_container
			template += "store_with CloudFiles do |cf|\n"
			template += "cf.api_key    = \"763fe3e8d52f7fc7512a0a3c955b415c\"\n"
			template += "cf.username   = \"roundscapes\"\n"
			template += "cf.container  = \"#{backup.cloudfile_container.name}\"\n"
			template += "cf.path = \"/#{backup.cloudfile_container.name}\"\n"
			template += "cf.keep = 5\n"
			template += "cf.auth_url = \"auth.api.rackspacecloud.com\"\n"
			template += "cf.servicenet = false\n"
			template += "end\n"
		end
		if backup.app.db_type == "mysql"
			template += "database MySQL do |db|\n"
			template += "db.additional_options = [\"--quick\", \"--single-transaction\"]\n"
		elsif backup.app.db_type == "postgresql"
			template += "database PostgreSQL do |db|\n"
			template += "db.additional_options = [\"-xc\", \"-E=utf8\"]\n"
		end
		template += "db.name = \"#{backup.app.db_name}\"\n"
		template += "db.username = \"#{backup.app.db_username}\"\n"
		template += "db.password = \"#{backup.app.db_password}\"\n"
		template += "end\n"
		if backup.sftp_storage
			template += "store_with SFTP do |server|\n"
			template += "server.username = \"#{backup.sftp_storage.server_username}\"\n"
			template += "server.ip = #{backup.sftp_storage.server_ip}\n"
			template += "server.port = 22"
			template += "server.path = #{backup.sftp_storage.server_path}\n"
			template += "server.keep = 5\n"
			template += "end\n"
		end
		template += "compress_with Gzip\n"
		template += "end"
	end
end