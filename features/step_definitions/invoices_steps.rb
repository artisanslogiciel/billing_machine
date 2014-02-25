
Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @user.entity)
end

When(/^the user goes to the invoices page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^he creates a new invoice$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^he fills the reference, the date and the payment terms$/) do
  pending # express the regexp above with the code you wish you had
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
