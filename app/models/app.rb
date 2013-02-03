class App < ActiveRecord::Base
	attr_accessible :name, :server_ip, :server_password, :server_path, :server_username, :ssh_verified, :rails_version,
					:needs_updated, :cloudfile_container_id, :sftp_storage_id, :db_type, :db_name, :db_username, :db_password

	# Validations
	validates :name, presence: true
	validates :server_ip, presence: true
	validates :server_path, presence: true
	validates :server_username, presence: true
	validates_inclusion_of :db_type, in: ['mysql', 'postgresql']

	# Associations
	# has_one :app_cloudfile_container
	# has_one :cloudfile_container, through: :app_cloudfile_container
	belongs_to :cloudfile_container
	belongs_to :sftp_storage
	has_many :backups, dependent: :destroy

	# Nested Attributes
	accepts_nested_attributes_for :cloudfile_container

	# checks if the app credientials get us ssh access
	# TODO: rescue from other ssh errors other than authentiation failed
	def check_key
		begin
			ssh = Net::SSH.start(self.server_ip, self.server_username)
		rescue Net::SSH::AuthenticationFailed
			begin
				ssh = Net::SSH.start(self.server_ip, self.server_username, password: self.server_password)
				needs_key = true
			rescue
				ssh = false
				logger.debug 'yoyoyo'
			end
		end

		if needs_key
			add_ssh_key if needs_key
		elsif ssh
			true
		else
			false
		end
	end

	# gets the version of the rails app
	# TODO: frontend validation that app is ssh verified
	# TODO: on both verify ssh and version buttons in view, add progress indicator
	# TODO: some servers (ie barhappy), do not load the rails path in .bash_profile
	def get_version
		if self.ssh_verified
			require "#{Rails.root}/lib/get_current_version.rb"
			ssh = Net::SSH.start(self.server_ip, self.server_username)
			version = ssh.exec!("source ~/.bash_profile; cd #{self.server_path}; rails -v")
			self.update_attributes(needs_updated: false) if version.tr('^0-9.', '').gsub('.', '').to_i >= GetCurrentVersion.current_rails_version.gsub('.', '').to_i
			version
		else
			false
		end
	end

	# Version with no periods, used for comparisons with other versions
	def rails_version_comp
		self.rails_version.gsub('.', '')
	end

	private

	# gets local ssh key and adds to remote authorized_keys
	# TODO: check if remote file exists, create it if it doesnt
	def add_ssh_key
		key = `cat ~/.ssh/id_rsa.pub`
		Net::SSH.start(self.server_ip, self.server_username, password: self.server_password) do |ssh|
			ssh.exec!("echo \"#{key}\" >> ~/.ssh/authorized_keys")
		end
		true
	end
end
