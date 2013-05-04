# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130504183708) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "server_ip"
    t.string   "server_path"
    t.string   "server_username"
    t.string   "server_password"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "ssh_verified"
    t.string   "rails_version"
    t.boolean  "needs_updated"
    t.integer  "cloudfile_container_id"
    t.integer  "sftp_storage_id"
    t.string   "db_type"
    t.string   "db_name"
    t.string   "db_username"
    t.string   "db_password"
  end

  create_table "backups", :force => true do |t|
    t.integer  "app_id"
    t.integer  "cloudfile_container_id"
    t.integer  "sftp_storage_id"
    t.text     "schedule_time"
    t.datetime "last_performed"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "backups", ["app_id"], :name => "index_backups_on_app_id"
  add_index "backups", ["cloudfile_container_id"], :name => "index_backups_on_cloudfile_container_id"
  add_index "backups", ["sftp_storage_id"], :name => "index_backups_on_sftp_storage_id"

  create_table "cloudfile_containers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "api_key"
    t.string   "username"
  end

  create_table "sftp_storages", :force => true do |t|
    t.string   "name"
    t.string   "server_ip"
    t.string   "server_username"
    t.string   "server_password"
    t.string   "server_path"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
