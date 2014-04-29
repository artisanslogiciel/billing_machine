# Read about factories at https://github.com/thoughtbot/factory_girl

# All values in factories used for invoice should be different because invoice
# generation tests check for text inclusion in final result so equal values
# will make pass tests that shouln't !
FactoryGirl.define do
  factory :invoice_line do
    label 'Bidule'
    quantity '5'
    unit 'hours'
    unit_price '2.1'
    total '10.55'
    invoice
    
    factory :invoice_line_2 do
      label 'Truc'
      quantity '13.37'
      unit 'nuts'
      unit_price '42'
      total '561.54'
      invoice
    end
  end
  
end
