# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_term do
    label 'Upon reception'
    entity
  end
end
