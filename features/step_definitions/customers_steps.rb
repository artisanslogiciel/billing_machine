#encoding: utf-8

When(/^the user goes to the customers page$/) do
  visit('/')
  pending # TODO
  click_link 'customers'
end

When(/^he creates a new customer$/) do
  click_link 'new-customer'
end

When(/^he fills the name, short name, full address, country and CEDEX$/) do
  fill_in 'customer-name', with: @customer_name = 'Awesome SARL'

  fill_in 'customer-address1', with: '1er étage Tour Address1'
  fill_in 'customer-address2', with: '42 rue Address2'
  fill_in 'customer-zip', with: '13392'
  fill_in 'customer-city', with: 'Marseille'

  fill_in 'customer-country', with: 'France'
  fill_in 'customer-cedex', with: 'CEDEX 5'
end

When(/^he saves the customer$/) do
  click_link 'submit'
end

Then(/^it's added to the customers list$/) do
  click_link 'customers'
  page.should have_selector '.customer .name', text: @customer_name
end

Then(/^the new customer is usable$/) do
  assert page.has_select?('invoice-customer', :with_options => [@customer_name])
end


When(/^he edits the customer$/) do
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
