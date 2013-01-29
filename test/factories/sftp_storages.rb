# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sftp_storage do
    name "this_storage"
    server_ip "123.45.678.90"
    server_username "cool_username"
    server_password "TITS8008s"
    server_path "/path/to/remote"
  end
end
