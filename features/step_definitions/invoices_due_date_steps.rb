#encoding: utf-8

When(/^he sets a due date$/) do
  fill_in 'invoice-due-date', with: @due_date = '2014-08-05'
end

Then(/^the due date is still there$/) do
  page.should have_field('invoice-due-date', with: @due_date)
end

Then(/^the invoice paid status should be green$/) do
  find("#paid")[:class].should include("green")
end
