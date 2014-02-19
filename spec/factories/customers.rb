# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name 'MyString'
    address1 'MyString'
    address2 'MyString'
    zip 1
    city 'MyString'
  end
end
