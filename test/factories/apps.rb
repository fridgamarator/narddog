# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :app do
    name "sweet app"
    server_ip "123.45.678.90"
    server_path "/path/to/remote"
    server_username "coolusername"
    server_password "8008s"
  end
end
