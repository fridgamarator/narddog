class AddRecurrenceFieldToBackups < ActiveRecord::Migration
  def up
    add_column :backups, :schedule_rule, :text
    remove_column :backups, :schedule_time
    add_column :backups, :schedule_time, :time
  end

  def down
  	remove_column :backups, :schedule_time
  	add_column :backups, :schedule_time, :datetime
  	remove_column :backups, :schedule_rule
  end
end
