# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shared do
    device_id 1
    user_id 1
    user_shared 1
    from_date "2013-10-06 23:13:35"
    to_date "2013-10-06 23:13:35"
    visibility 1
  end
end
