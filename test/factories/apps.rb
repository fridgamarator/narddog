# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    name "sweet app"
    server_ip "123.45.678.90"
    server_path "/path/to/remote"
    server_username "coolusername"
    server_password "8008s"
    ssh_verified false
    rails_version '3.2.11'
    db_type 'msyql'
    db_name 'app_production'
    db_username 'username'
    db_password 'asdfqwer12'
  end
end
