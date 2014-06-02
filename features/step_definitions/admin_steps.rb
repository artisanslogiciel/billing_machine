Then(/^the link to the admin section should be visible$/) do
  page.should have_link('Admin')
  find_link("admin-section").should be_visible
end

When(/^he clicks on the admin link$/) do
   click_link 'admin-section'
end

Then(/^he should be on the admin section$/) do
  current_path.should be == '/admin'
end

When(/^the administrator is on the admin section home page$/) do
  visit '/admin'
end

Then(/^the link to the application home page should be visible$/) do
  find_link('Application').should be_visible
end

When(/^he clicks on the application link$/) do
  click_link 'Application'
end

Then(/^he should be on application home page$/) do
  current_path.should be == '/'
end

Then(/^he doesn't see the admin section tab$/) do
  page.should have_no_selector '#admin-section'
end
