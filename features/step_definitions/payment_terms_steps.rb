When(/^the administrator goes to the payment terms administration page$/) do
  visit '/admin'
  click_link 'Payment Terms'
end

When(/^he goes to the new payment term page$/) do
  click_link 'New Payment Term'
end

When(/^he adds a payment term$/) do
  @new_payment_term = "My new payment term"
  fill_in "payment_term_label", with: @new_payment_term
  click_button 'Create Payment term'
end

Then(/^the payment term is added to the list$/) do
  # TODO: find why it doesn't work with RSpec syntax
  assert page.has_select?('invoice-payment-term', :with_options => [@new_payment_term])
end
