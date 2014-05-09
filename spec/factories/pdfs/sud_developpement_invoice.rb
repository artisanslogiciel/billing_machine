# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
    factory :sud_developpement_invoice do
      invoice
      initialize_with { SudDeveloppementInvoice.new(invoice) }
  end
end
