# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_slice do
    day '2013-12-17'
    project
    duration '7'
    activity
  end
end
