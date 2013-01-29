class CreateSftpStorages < ActiveRecord::Migration
  def change
    create_table :sftp_storages do |t|
      t.string :name
      t.string :server_ip
      t.string :server_username
      t.string :server_password
      t.string :server_path

      t.timestamps
    end
  end
end
