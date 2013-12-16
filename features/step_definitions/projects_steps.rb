require 'securerandom'

Given(/^a user on the project page$/) do
  visit('/projects')
end

When(/^I fill the project name$/) do
  @project_name = "New Project - #{SecureRandom.hex(3)}"
  fill_in 'new-project-name', with: @project_name
end

When(/^creates a new project$/) do
  click_button('new-project')
end

Then(/^the project is added to the project list$/) do
  page.should have_selector 'li.project', text: @project_name
end
