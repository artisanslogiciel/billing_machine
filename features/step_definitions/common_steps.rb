Given(/^an existing user$/) do
  @user = FactoryGirl.create(:user)
  sign_in @user
end

Given(/^an existing administrator$/) do
  @admin_user = FactoryGirl.create(:admin_user)
  sign_in @admin_user
end

Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @user.entity)
end

When(/^the (user|administrator) is on the home page$/) do |arg1|
  visit '/'
end
