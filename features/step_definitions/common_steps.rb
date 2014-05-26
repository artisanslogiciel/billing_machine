Given(/^an existing user$/) do
  @user = FactoryGirl.create(:user)
  sign_in @user
end

Given(/^an existing administrator$/) do
  @user = FactoryGirl.create(:admin_user)
  sign_in @user
end

Given(/^an existing customer$/) do
  @customer = FactoryGirl.create(:customer, entity: @user.entity)
end
