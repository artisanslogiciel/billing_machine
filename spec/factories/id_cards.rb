# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :id_card do
    name "AGILiDEE"
    entity
    legal_form 'SA'
    capital 1000000000
    registration_number 'RCS 123456789'
  end
end
