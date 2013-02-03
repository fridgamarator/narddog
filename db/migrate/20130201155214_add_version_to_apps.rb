class AddVersionToApps < ActiveRecord::Migration
  def change
    add_column :apps, :rails_version, :string
    add_column :apps, :needs_updated, :boolean
    add_column :apps, :cloudfile_container_id, :integer
    add_column :apps, :sftp_storage_id, :integer
  end
end
