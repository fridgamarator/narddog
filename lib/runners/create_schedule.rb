# Creates the whenever schedule.rb file

time = Time.now.beginning_of_day
end_string = ''

1.upto(48).each do |i|
	schedule_time = time.strftime("%I:%M %p")
	loop_string = "every :day, at: '#{schedule_time}' do\n"
		loop_string += "\t#run some method with #{schedule_time}\n"
		loop_string += "\trake 'backups:run_backups time=\"#{schedule_time}\"'\n"
	loop_string += "end\n"
	end_string += loop_string
	time = time + 30.minutes
end

File.open("#{Rails.root}/config/schedule.rb", "w"){|f| f << end_string }