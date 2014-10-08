#encoding: utf-8
require 'cucumber/rspec/doubles'

When(/^the new invoice insertion fail$/) do
  Invoice.any_instance.stub(:save).and_return(false)
  click_link 'submit'
end

Then(/^a message signals the fail of the invoice creation$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Invoice not saved due to an internal error"
end
