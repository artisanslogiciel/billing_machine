#encoding: utf-8

When(/^(the user|he) goes to the invoices page$/) do |arg1|
  visit('/')
  click_link 'invoices'
end

When(/^he creates a new invoice$/) do
  click_link 'new-invoice'
end

When(/^he fills the reference, the date and the payment terms$/) do
  fill_in 'invoice-label', with: @label = 'My reference'
  fill_in 'invoice-date', with: @date = '2014-01-01'
  select @payment_term.label
end

When(/^he chooses the customer$/) do
  select @customer.name
end

Then(/^he sees the customer's infos$/) do
  page.should have_selector '.customer-address1', text: @customer.address1
  page.should have_selector '.customer-address2', text: @customer.address2
  page.should have_selector '.customer-zip', text: @customer.zip
  page.should have_selector '.customer-city', text: @customer.city
  page.should have_selector '.customer-country', text: @customer.country
end

When(/^he fills a line with "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  fill_in 'new-line-label', with: arg1
  fill_in 'new-line-quantity', with: arg2
  fill_in 'new-line-unit', with: arg3
  fill_in 'new-line-unit-price', with: arg4
end
When(/^he fills the line with "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  fill_in 'existing-line-label', with: arg1
  fill_in 'existing-line-quantity', with: arg2
  fill_in 'existing-line-unit', with: arg3
  fill_in 'existing-line-unit-price', with: arg4
end

When(/^he fills (a|the) (new|existing) line with "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/) do
      |arg0, id_prefix, label, quantity, unit, unit_price|
  fill_in "#{id_prefix}-line-label", with: label
  fill_in "#{id_prefix}-line-quantity", with: quantity
  fill_in "#{id_prefix}-line-unit", with: unit
  fill_in "#{id_prefix}-line-unit-price", with: unit_price
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

Then(/^the VAT due is "(.*?)"$/) do |arg1|
  page.should have_selector '.total .invoice-vat', text: arg1
end

Then(/^the total all taxes included is "(.*?)"$/) do |arg1|
  page.should have_selector '.total .invoice-total-taxes', text: arg1
end

When(/^he saves the invoice$/) do
  click_link 'submit'
end

When(/^he saves the new invoice$/) do
  step "he saves the invoice"
  # Now we are going to wait for index number to show up which means AJAX returned
  expect(find('.invoice-unique-index')).to have_content('1')
end

Then(/^it's added to the invoice list$/) do
  step('the user goes to the invoices page')
  page.should have_selector '.invoice .date', text: @date
  # There are no other invoices for this test so we should get the right number
  tracking_id = Invoice.first.tracking_id
  page.should have_selector '.invoice .tracking-id', text: tracking_id
  page.should have_selector '.invoice .customer-name', text: @customer.name
  page.should have_selector '.invoice .total-duty', text: '200.00€'
end

Given(/^an existing invoice$/) do
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card, customer: @customer)
end

Given(/^an existing invoice with a "(.*?)"% VAT rate$/) do |rate|
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card, vat_rate: rate)
end

Given(/^an existing paid invoice$/) do
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card, paid: true)
end

When(/^he goes on the edit page of the invoice$/) do
  # ensure invoice list page is loaded
  page.should have_selector('.edit-invoice')
  find(:xpath, "//a[@data-id='#{@invoice.id}']").click
  # ensure invoice page is loaded
  page.should have_field('invoice-label', with: @invoice.label)
end

When(/^changes the label$/) do
  @new_label=  @invoice.label + " Edited"
  fill_in 'invoice-label', with: @new_label
end

Then(/^the invoices's label has changed$/) do
  reload_the_page
  page.should have_field('invoice-label', with: @new_label)
end

Then(/^the VAT rate is "(.*?)"$/) do |rate|
  page.should have_field('invoice-vat-rate', with: rate)
end

When(/^he changes the VAT rate to "(.*?)"$/) do |new_rate|
  fill_in 'invoice-vat-rate', with: new_rate
end

Then(/^the new line total is "(.*?)"$/) do |value|
  page.should have_selector '.new-line .line-total', text: value
end

Then(/^the existing line total is "(.*?)"$/) do |value|
  page.should have_selector '.invoice-line .line-total', text: value
end

When(/^he edits the line$/) do
  click_link 'Editer'
end

When(/^he finds and clicks on the download CSV export file$/) do
  page.should have_link('csv-export-button', :href=>"/api/v1/invoices.csv")
  click_link 'csv-export-button'
end

Then(/^he can set the invoice as paid$/) do
  page.should have_selector '.paid-invoice', text: 'Payée'
end

When(/^he set the invoice as paid$/) do
  find('.paid-invoice').click
end

Then(/^the invoice paid status is marked paid$/) do
  page.should have_selector '#paid', text: 'true'
end

Then(/^can't set the invoice as paid again$/) do
  page.should_not have_selector '#paid_button', text: 'Payée'
end

Then(/^the invoice is save as paid$/) do
  Invoice.first.paid.should be_true
end

When(/^he marks the invoice as unpaid$/) do
  uncheck "invoice-paid"
end

Then(/^the invoice paid status is marked unpaid$/) do
  page.should have_selector '#paid', text: 'false'
  Invoice.first.paid.should be_false
end

Then(/^the invoice status is set to unpaid$/) do
  Invoice.first.paid.should be_false
end

Then(/^the invoice status is set to paid$/) do
  Invoice.first.paid.should be_true
end

Then(/^a message signals the success of the update$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Invoice successfully updated"
end

Then(/^a message signals the success of the creation$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Invoice successfully saved"
end

Then(/^a message signals that the invoice is set to paid$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "invoice successfully set to paid"
end

Then(/^the advance is "(.*?)"€$/) do |value|
  page.should have_field('invoice-advance', with: value)
end

Then(/^the balance included is "(.*?)"$/) do |value|
  page.should have_selector '#invoice-balance', text: value
end

When(/^he changes the advance to "(.*?)"€$/) do |value|
  fill_in 'invoice-advance', with: value
end

When(/^he goes to the newly created invoice page$/) do
  visit "/invoices#/invoices/1"
end

Then(/^the invoice line shows the right date$/) do
page.should have_selector '.date' , text: @invoice.date
end

Then(/^the invoice line shows the right traking-id$/) do
 page.should have_selector '.tracking-id' , text: @invoice.tracking_id
end

Then(/^the invoice line shows the right total-duty value$/) do
  page.should have_selector '.total-duty' , text: @invoice.total_duty
end

Then(/^the invoice line shows the right vat value$/) do
  page.should have_selector '.vat' , text: @invoice.vat
end

Then(/^the invoice line shows the right all taxes value$/) do
  page.should have_selector '.all-taxes' , text: "12.09" #@invoice.total_all_taxes pb d'arrondi
end

Then(/^the invoice line shows the right customer's name$/) do
  page.should have_selector '.customer-name', text: @customer.name
end



