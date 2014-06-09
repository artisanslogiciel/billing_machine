Given(/^an existing entity$/) do
  @entity = FactoryGirl.create(:entity, name: "My entity")
end

Given(/^an existing user$/) do
  step('an existing entity') unless @entity
  @user = FactoryGirl.create(:user, entity: @entity)
  sign_in @user
end

Given(/^an existing administrator$/) do
  step('an existing entity') unless @entity
  @admin_user = FactoryGirl.create(:admin_user, entity: @entity)
  sign_in @admin_user
end

Given(/^an existing customer$/) do
  step('an existing entity') unless @entity 
  @customer = FactoryGirl.create(:customer, entity: @entity, country: "Hong kong")
end

When(/^the (user|administrator) is on the home page$/) do |arg1|
  visit '/'
end
