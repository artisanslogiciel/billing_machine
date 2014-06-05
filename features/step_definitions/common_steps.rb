Given(/^an existing user$/) do
  @user = FactoryGirl.create(:user)
  sign_in @user
end

Given(/^an existing administrator$/) do
  @admin_user = FactoryGirl.create(:admin_user)
  sign_in @admin_user
end

Given(/^an existing customer$/) do

  @customer = FactoryGirl.create(:customer, entity: @user.entity, country: "Hong kong")
end

When(/^the (user|administrator) is on the home page$/) do |arg1|
  visit '/'
end

Given(/^an existing payment term from the same entity$/) do
  @payment_term_same_entity = FactoryGirl.create(:payment_term,
      label: 'My payment term', entity: @entity)
end

Given(/^an existing payment term$/) do
  @payment_term = FactoryGirl.create(:payment_term, entity: @user.entity)
end
