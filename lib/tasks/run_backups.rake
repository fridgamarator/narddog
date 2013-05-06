namespace :backups do
	desc 'run backups at arg time'
	task :run_backups => :environment do
		require "/Users/nick/Sites/NardDog/lib/run_backups.rb"
		backups = Backup.where(schedule_time: ENV['time'])
		backups.each do |backup|
			RunBackups.run_backup(backup)
			backup.update_attributes(last_performed: Time.now)
		end
		puts "#{backups.count} run"
	end
end