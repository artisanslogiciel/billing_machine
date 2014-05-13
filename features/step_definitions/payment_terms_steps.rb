When(/^the administrator goes to the payment terms administration page$/) do
  visit '/admin'
  click_link 'Payment Terms'
  click_link 'New Payment Term'
end

When(/^he adds a payment term$/) do
  @new_payment_term = "My new payment term"
  fill_in "payment_term_label", with: @new_payment_term
  click_button 'Create Payment term'
end

When(/^he goes to the new invoice page$/) do
  visit '/'
  click_link "Billing Machine"
  click_link "Nouvelle facture"
end

Then(/^the payment term is added to the list$/) do
  select @new_payment_term, from: 'invoice-payment-term'
end