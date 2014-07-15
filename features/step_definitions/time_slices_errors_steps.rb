When(/^he creates a new time slice without a date$/) do
  fill_in 'new-time-slice-duration', with: '4.23'
  click_button 'new-time-slice-submit'
end

Then(/^a messsage signals a problem with the date$/) do
  find('#error-message').should be_visible
  page.should have_selector '#error-message', text: "Please fill a valid date"
end

When(/^he creates a new time slice with an invalid duration$/) do
  fill_in 'new-time-slice-duration', with: "I'm not a duration"
  fill_in 'new-time-slice-day', with: '1970-01-01'
  click_button 'new-time-slice-submit'
end

Then(/^a messsage signals a problem with the duration$/) do
  find('#error-message').should be_visible
  page.should have_selector '#error-message', text: "Duration is not a number"
end
