# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :backup do
    app nil
    cloudfile_container nil
    sftp_storage nil
    schedule_time "2013-02-02 14:50:47"
    last_performed "2013-02-02 14:50:47"
  end
end
