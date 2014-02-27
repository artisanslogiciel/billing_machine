# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
    name 'ACME'
    address1 '69 Toon Street'
    address2 ''
    zip 77777
    entity
  end
end
