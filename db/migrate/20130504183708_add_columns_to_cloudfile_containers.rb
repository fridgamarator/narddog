class AddColumnsToCloudfileContainers < ActiveRecord::Migration
  def change
    add_column :cloudfile_containers, :api_key, :string
    add_column :cloudfile_containers, :username, :string
  end
end
