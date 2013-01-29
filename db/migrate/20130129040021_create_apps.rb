class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :server_ip
      t.string :server_path
      t.string :server_username
      t.string :server_password

      t.timestamps
    end
  end
end
