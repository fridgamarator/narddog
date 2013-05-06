module BackupsHelper
	def schedule_rule_select
		stuff = []
		stuff << [IceCube::Rule.daily, IceCube::Schedule.new{|s| s.add_recurrence_rule(IceCube::Rule.daily)}.to_yaml]
		0.upto(6).each do |i|
			stuff << [IceCube::Rule.weekly.day(i), IceCube::Schedule.new{|s| s.add_recurrence_rule(IceCube::Rule.weekly.day(i))}.to_yaml]
		end
		stuff
	end
end
