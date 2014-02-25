
Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @user.entity)
end

When(/^the user goes to the invoices page$/) do
  visit(invoices_path)
end

When(/^he creates a new invoice$/) do
  click_link 'new-invoice'
end

When(/^he fills the reference, the date and the payment terms$/) do
  fill_in 'invoice-reference', with: 'My reference'
  fill_in 'invoice-date', with: '2014-01-01'
  select PaymentTerm.first.label
end

When(/^he adds a line "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  pending # express the regexp above with the code you wish you had
end

Then(/^the total duty is "(.*?)"_$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the total all taxes included is "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^the balance due is "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
