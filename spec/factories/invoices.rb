# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    date '2014-02-19'
    customer
    payment_term
    label 'Software service'
    total_duty '9.99'
    vat '20.99'
    total_all_taxes '12.086901'
    advance '1.00'
    balance '11.086901'
    vat_rate '20.0'

    id_card
  end
end
