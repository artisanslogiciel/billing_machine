Before do
  step 'an existing entity'
end

Given(/^an existing entity$/) do
  @entity = FactoryGirl.create(:entity, name: "My entity")
  FactoryGirl.create(:id_card, entity: @entity)
end

Given(/^an existing user$/) do
  @user = FactoryGirl.create(:user, entity: @entity)
  sign_in @user
end

Given(/^an existing administrator$/) do
  @admin_user = FactoryGirl.create(:admin_user, entity: @entity)
  sign_in @admin_user
end

Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @entity, country: "Hong kong")
end

When(/^the (user|administrator) is on the home page$/) do |arg1|
  visit '/'
end

When(/^he reload the page$/) do
  reload_the_page
end
