Given(/^an existing user$/) do
  @user = FactoryGirl.create(:user)
  sign_in @user
end
