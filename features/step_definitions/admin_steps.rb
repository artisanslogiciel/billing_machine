When(/^the administrator is on the home page$/) do
  visit '/'
end

Then(/^the link to the admin section should be visible$/) do
  page.should have_link('Admin')
  find_link("admin-section").should be_visible
end

When(/^he clicks on the link$/) do
  click_link 'admin-section'
end

Then(/^he should be on the admin section$/) do
  assert_equal '/admin', current_path
end
