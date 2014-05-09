# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
    factory :agilidee_invoice do
      invoice
      initialize_with { AgilideeInvoice.new(invoice) }
  end
end
