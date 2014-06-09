Given(/^an existing entity$/) do
  @entity = FactoryGirl.create(:entity, name: "My entity")
end

Given(/^an existing user$/) do
  if @entity
    @user = FactoryGirl.create(:user, entity: @entity)
  else
    @user = FactoryGirl.create(:user)
  end
  sign_in @user
end

Given(/^an existing administrator$/) do
  if @entity
    @admin_user = FactoryGirl.create(:admin_user, entity: @entity)
  else
    @admin_user = FactoryGirl.create(:admin_user)
  end
  sign_in @admin_user
end

Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @entity, country: "Hong kong")
end

When(/^the (user|administrator) is on the home page$/) do |arg1|
  visit '/'
end
