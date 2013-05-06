module BackupsHelper
	def schedule_rule_select
		stuff = []
		stuff << [IceCube::Rule.daily, IceCube::Schedule.new{|s| s.add_recurrence_rule(IceCube::Rule.daily)}.to_yaml] #.stringify_keys.to_s
		0.upto(6).each do |i|
			t = IceCube::Rule.weekly.day(i).to_hash
			t[:validations].try(:stringify_keys!)
			t.stringify_keys!
			stuff << [IceCube::Rule.weekly.day(i), IceCube::Schedule.new{|s| s.add_recurrence_rule(IceCube::Rule.weekly.day(i))}.to_yaml] #t.to_s
		end
		stuff
	end
end
