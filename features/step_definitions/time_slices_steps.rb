When(/^the user goes in the time slices section$/) do
  visit('/time_slices')
end

Given(/^an existing activity$/) do
  @activity = FactoryGirl.create(:activity)
end

Given(/^an existing time slice$/) do
  @time_slice = FactoryGirl.create(:time_slice, user: @user)
end

When(/^he creates a new time slice$/) do
  fill_in 'new-time-slice-duration', with: '4.23'
  fill_in 'new-time-slice-day', with: '1970-01-01'
  fill_in 'new-time-slice-comment', with: 'Hello World'
  click_button 'new-time-slice-submit'
end

Then(/^the time slice is added to the list$/) do
  expect(page).to have_selector '.time-slice .duration', text: '4.23'
  expect(page).to have_selector '.time-slice .comment', text: 'Hello World'
  expect(page).to have_selector '.time-slice .day', text: '1970-01-01'
  reload_the_page
  expect(page).to have_selector '.time-slice .duration', text: '4.23'
  expect(page).to have_selector '.time-slice .comment', text: 'Hello World'
  expect(page).to have_selector '.time-slice .day', text: '1970-01-01'
end

Then(/^the duration should be required$/) do
  find_field('new-time-slice-duration')[:required].should == "true"
end

When(/^he edits the time slices' duration$/) do
  click_link "edit-#{@time_slice.id}"
end

Then(/^the current time slices' duration should be pre\-filled$/) do
  expect(page).to have_field("edit-time-slice-duration-#{@time_slice.id}", with: @time_slice.duration.to_s)
end

When(/^he validates the new duration$/) do
  @new_duration = @time_slice.duration + 2
  fill_in "edit-time-slice-duration-#{@time_slice.id}", with: @new_duration.to_s
  click_button("submit-time-slice-#{@time_slice.id}")
end

Then(/^the time slices' duration is updated$/) do
  page.should have_selector '.time-slice .duration', text: @new_duration
  reload_the_page
  page.should have_selector '.time-slice .duration', text: @new_duration
end

Then(/^he should be able to download the CSV export file$/) do
  page.should have_link('csv-export-button', :href=>"/api/v1/time_slices.csv")
  click_link 'csv-export-button'
end

Then(/^downloaded the CSV should be valid with expected information$/) do
  page.driver.response.headers['Content-Type'].should include 'text/csv'
  parsed_csv = CSV.parse(page.driver.response.body, options = {:col_sep => ';'})
  time_slice_data = parsed_csv[1]

  time_slice_data.should include @time_slice.day.iso8601
  time_slice_data.should include @time_slice.comment
  time_slice_data.should include @time_slice.duration.to_s
end
