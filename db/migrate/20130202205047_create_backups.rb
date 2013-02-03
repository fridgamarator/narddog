class CreateBackups < ActiveRecord::Migration
  def change
    create_table :backups do |t|
      t.references :app
      t.references :cloudfile_container
      t.references :sftp_storage
      t.datetime :schedule_time
      t.datetime :last_performed

      t.timestamps
    end
    add_index :backups, :app_id
    add_index :backups, :cloudfile_container_id
    add_index :backups, :sftp_storage_id
  end
end
