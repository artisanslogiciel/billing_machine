# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entity do
    name 'ACME'
    address1 '1 Mickey Boulevard'
    address2 ''
    zip 77777
    city 'Donald City'
    
    billing_machine true
    time_machine true
    customization_prefix 'agilidee'
  end
end
