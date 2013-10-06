# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device do
    imei "MyString"
    name "MyString"
    last_seen "2013-10-06 16:23:05"
  end
end
