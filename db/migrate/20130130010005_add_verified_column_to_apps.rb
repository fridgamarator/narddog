class AddVerifiedColumnToApps < ActiveRecord::Migration
  def change
    add_column :apps, :ssh_verified, :boolean
  end
end
