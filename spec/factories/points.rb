# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    latitude 1.5
    longitude 1.5
    speed 1.5
    height 1.5
    course 1.5
    accuracy 1.5
    provider "MyString"
    timefix "2013-10-06 16:23:38"
  end
end
