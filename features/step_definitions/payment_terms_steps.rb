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

Given(/^an existing payment term from this other entity$/) do
  @payment_term_other_entity = FactoryGirl.create(:payment_term,
      label: 'Other payment term', entity: @other_entity)
end

When(/^goes to the payment terms page$/) do
  click_on 'Payment Terms'
end

Then(/^he should see the payment term from his entity$/) do
  page.should have_content('My payment term')
end

Then(/^he should not see the payment term from another entity$/) do
  page.should have_no_content('Other payment term')
end

Then(/^he doesn't see the filter for entity$/) do
  page.should have_no_selector '#q_entity_id'
end

Then(/^he doesn't see the entity select field$/) do
  page.should have_no_selector '#payment_term_entity_id'
end
