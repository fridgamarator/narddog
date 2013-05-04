# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cloudfile_container do
    name "app_bucket"
    api_key 'sdflkjsdlfkjslkj234l2k3jlkfsfd'
    username 'some_username'
  end
end
