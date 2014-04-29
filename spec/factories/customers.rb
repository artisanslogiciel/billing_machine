# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name 'ACME'
    address1 '69 Toon Street'
    address2 'address2 value'
    zip 66666
    city 'Mickey City'
    entity
  end
end
