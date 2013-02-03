class AddColumnsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :db_type, :string
    add_column :apps, :db_name, :string
    add_column :apps, :db_username, :string
    add_column :apps, :db_password, :string
  end
end
