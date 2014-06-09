#encoding: utf-8

When(/^the administrator goes to the customers page$/) do
  visit('/admin')
  click_link 'Customers'
end

When(/^he creates a new customer$/) do
  click_link 'New Customer'
end

When(/^he fills the name, short name, full address, country, IBAN and BIC\/SWIFT$/) do
  fill_in 'customer-name', with: @customer_name = 'Awesome SARL'
  fill_in 'customer-short-name', with: @customer_short_name = 'Awesome'

  fill_in 'customer-address1', with: @address1 = '1er étage Tour Address1'
  fill_in 'customer-address2', with: @address2 ='42 rue Address2'
  fill_in 'customer-zip', with: @zip = '13392'
  fill_in 'customer-city', with: @city = 'Marseille'

  fill_in 'customer-country', with: @country = 'France'
  # TODO add to database
#   fill_in 'customer-iban', with: @iban = 'FR19 2004 1100 2000 0000 0000 T15'
#   fill_in 'customer-bic-swift', with: @bic_swift = 'PSSTFRPPREN'
end

When(/^he saves the customer$/) do
  click_button 'Create Customer'
end

Then(/^it's added to the customers list$/) do
  click_link 'customers'
  page.should have_selector '.customer .name', text: @customer_name
end

Then(/^all the fields are filled with the right values$/) do
  page.should have_field('customer-name', with: @customer_name)
  page.should have_field('customer-address1', with: @customer_address1)
  page.should have_field('customer-address2', with: @customer_address2)
  page.should have_field('customer-zip', with: @zip)
  page.should have_field('customer-city', with: @city)
  page.should have_field('customer-country', with: @country)
  # TODO add to database
#   page.should have_field('customer-iban', with: @iban)
#   page.should have_field('customer-bic-swift', with: @bic_swift)
end

Then(/^the new customer is usable$/) do
  # TODO this will be the selector for Customer Vault (customer management V2)
  assert page.has_select?('invoice-customer', :with_options => [@customer_name])
end


When(/^he edits the customer$/) do
  pending 'useless for Active Admin implementation, keep for Customer Vault (customer management V2)'
  # find edit button for @invoice which have a data-id attribute equal to @customer.id
  edit_button = find(:xpath, "//a[@data-id='#{@customer.id}']")
  edit_button.click
end

When(/^changes his name$/) do
  @new_name= 'Incredibly Awesome SARL'
  fill_in 'customer-name', with: @new_name
end

Then(/^the customer's name has changed$/) do
  reload_the_page
  page.should have_field('customer-name', with: @new_name)
end
