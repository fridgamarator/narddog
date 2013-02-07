class ChangeScheduleTimeToStringInBackups < ActiveRecord::Migration
  def up
  	change_column :backups, :schedule_time, :text
  end

  def down
  	change_column :backups, :schedule_time, :datetime
  end
end
