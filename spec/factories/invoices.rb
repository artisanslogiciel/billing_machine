# Read about factories at https://github.com/thoughtbot/factory_girl

# All values in factories used for invoice should be different because invoice
# generation tests check for text inclusion in final result so equal values
# will make pass tests that shouln't !
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
    entity
  end
end
