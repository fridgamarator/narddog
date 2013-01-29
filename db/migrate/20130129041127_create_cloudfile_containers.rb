class CreateCloudfileContainers < ActiveRecord::Migration
  def change
    create_table :cloudfile_containers do |t|
      t.string :name

      t.timestamps
    end
  end
end
