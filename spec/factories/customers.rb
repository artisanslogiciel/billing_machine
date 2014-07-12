# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name 'ACME'
    short_name 'AC'
    address1 '69 Toon Street'
    address2 ''
    zip 77777
    entity
  end
end
