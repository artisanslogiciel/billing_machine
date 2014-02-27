#encoding: utf-8

Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @user.entity)
end

When(/^the user goes to the invoices page$/) do
  visit('/')
  click_link 'invoices'
end

When(/^he creates a new invoice$/) do
  click_link 'new-invoice'
end

When(/^he fills the reference, the date and the payment terms$/) do
  fill_in 'invoice-reference', with: 'My reference'
  fill_in 'invoice-date', with: '2014-01-01'
  select PaymentTerm.first.label
end

When(/^he chooses the customer$/) do
  select @customer.name
  page.should have_selector '.customer-address1', text: @customer.address1
  page.should have_selector '.customer-address2', text: @customer.address2
  page.should have_selector '.customer-zip', text: @customer.zip
  page.should have_selector '.customer-city', text: @customer.city
end

When(/^he fills a line with "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  fill_in 'new-line-label', with: arg1
  fill_in 'new-line-quantity', with: arg2
  fill_in 'new-line-unit', with: arg3
  fill_in 'new-line-unit-price', with: arg4
end

Then(/^the new line's total should be "(.*?)"$/) do |arg1|
  page.should have_selector '.new-line .line-total', text: arg1
end


When(/^he adds the new line$/) do
  click_link 'add-new-line'
end

Then(/^the total duty is "(.*?)"$/) do |arg1|
  page.should have_selector '.total .invoice-total-duty', text: arg1
end

Then(/^the vat due is "(.*?)"$/) do |arg1|
  page.should have_selector '.total .invoice-vat', text: arg1
end

Then(/^the total all taxes included is "(.*?)"$/) do |arg1|
  page.should have_selector '.total .invoice-total-taxes', text: arg1
end
