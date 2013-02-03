# Module for getting and setting current rails version, used for comparisons of current rails apps versions

module GetCurrentVersion

	# Get current rails version from config file
	def self.current_rails_version
		require 'yaml'
		yaml = YAML::load_file("config/current_version.yml")
		yaml['current_version']
	end

	# self.current_rails_version stripping periods
	def self.current_rails_version_comp
		self.current_rails_version.gsub('.', '')
	end
end