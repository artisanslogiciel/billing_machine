require 'securerandom'

Given(/^the user goes on project page$/) do
  visit('/projects')
end


Given(/^an existing project$/) do
  @project = FactoryGirl.create(:project, :entity =>@user.entity)
end

When(/^he fills the project's name$/) do
  @project_name = "New Project - #{SecureRandom.hex(3)}"
  fill_in 'new-project-name', with: @project_name
end

When(/^he edits the project's name$/) do
  click_link "edit-#{@project.id}"
end

When(/^he validates the new name$/) do
  @new_name = "#{@project.name} #{SecureRandom.hex(3)}"
  fill_in "edit-project-name-#{@project.id}", with: @new_name
  click_button("submit-project-name-#{@project.id}")
end

When(/^creates a new project$/) do
  click_button('new-project')
end

Then(/^the current project's name should be pre\-filled$/) do
  expect(page).to have_field("edit-project-name-#{@project.id}", with: @project.name)
end

Then(/^the project is added to the project list$/) do
  page.should have_selector 'li.project .name', text: @project_name
  reload_the_page
  page.should have_selector 'li.project .name', text: @project_name
end

Then(/^the project's name is updated$/) do
  reload_the_page
  page.should have_selector 'li.project .name', text: @new_name
end
