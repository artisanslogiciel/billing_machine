#encoding: utf-8

Given(/^an existing user who wants to be notified about late invoices payments$/) do
  FactoryGirl.create(:user, notify_invoices_late_payments: true)
end

When(/^the scheduled task runs at (\d+):(\d+):(\d+)Z$/) do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Then(/^the user is notified$/) do
  pending # express the regexp above with the code you wish you had
end
