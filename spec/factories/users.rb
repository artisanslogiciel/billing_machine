# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email_#{n}@factory.com"
  end

  factory :user do
    first_name 'John'
    last_name 'Doe'
    email
    password 'motdepasse'
    entity
    billing_machine true
    time_machine true

    factory :admin_user do
      administrator true
    end

  end
end
