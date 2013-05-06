class ChangeScheduleTimeToString < ActiveRecord::Migration
  def up
  	change_column :backups, :schedule_time, :string
  end

  def down
  	change_column :backups, :schedule_time, :time
  end
end
