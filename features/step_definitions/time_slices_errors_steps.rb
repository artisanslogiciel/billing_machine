When(/^he creates a new time slice without a date$/) do
  fill_in 'new-time-slice-duration', with: '4.23'
  fill_in 'new-time-slice-comment', with: "I'm invalid"
  click_button 'new-time-slice-submit'
end

When(/^he creates a new time slice with an invalid date$/) do
  fill_in 'new-time-slice-duration', with: '4.23'
  fill_in 'new-time-slice-day', with: '1970-13-32'
  click_button 'new-time-slice-submit'
end

When(/^he creates a new time slice without a duration$/) do
  fill_in 'new-time-slice-day', with: '1970-01-01'
  click_button 'new-time-slice-submit'
end

When(/^he creates a new time slice with an invalid duration$/) do
  fill_in 'new-time-slice-duration', with: "I'm not a duration"
  fill_in 'new-time-slice-day', with: '1970-01-01'
  click_button 'new-time-slice-submit'
end

When(/^he creates a new time slice with a duration too big$/) do
  fill_in 'new-time-slice-duration', with: "13"
  fill_in 'new-time-slice-day', with: '1970-01-01'
  click_button 'new-time-slice-submit'
end

When(/^he creates a new time slice with a negative duration$/) do
  fill_in 'new-time-slice-duration', with: "-1"
  fill_in 'new-time-slice-day', with: '1970-01-01'
  click_button 'new-time-slice-submit'
end

Then(/^a messsage signals an empty date$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Please fill a valid date"
end

Then(/^a messsage signals a problem with the date$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Please fill a valid date"
end

Then(/^a messsage signals a problem with the duration$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Duration is not a number"
end

Then(/^a messsage signals a problem with the duration upper limit$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Duration must be less than 12"
end

Then(/^a messsage signals a problem with the duration lower limit$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Duration must be greater than 0"
end

Then(/^a messsage signals an empty duration$/) do
  find('#info-message').should be_visible
  page.should have_selector '#info-message', text: "Duration can't be blank"
end

Then(/^the time slice is not added to the list$/) do
  page.should have_no_content("I'm invalid")
end
