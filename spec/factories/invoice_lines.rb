# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice_line do
    label 'Bidule'
    quantity '9.99'
    unit '$'
    unit_price '9.99'
    total '99.88001'
    invoice
  end
end
