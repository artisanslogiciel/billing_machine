When(/^he creates a new time slice without a date$/) do
  fill_in 'new-time-slice-duration', with: '4.23'
  fill_in 'new-time-slice-comment', with: 'Hello World'
  click_button 'new-time-slice-submit'
end

Then(/^a messsage signals a problem with the date$/) do
  find('#error-message').should be_visible
  page.should have_selector '#error-message', text: "Please fill a valid date"
end
