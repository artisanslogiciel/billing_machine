#encoding: utf-8

When(/^he sets a due date$/) do
  fill_in 'invoice-due-date', with: @due_date = '2014-08-05'
end

Then(/^the due date is still there$/) do
  page.should have_field('invoice-due-date', with: @due_date)
end

Given(/^an existing unpaid invoice with a due date not yet passed$/) do
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card,
                                paid: false,
                                due_date: (Date.today + 1))
end

Given(/^an existing unpaid invoice with a due date the same day$/) do
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card,
                                paid: false,
                                due_date: (Date.today))
end

Given(/^an existing unpaid invoice with a due date yesterday$/) do
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card,
                                paid: false,
                                due_date: (Date.today - 1))
end

Given(/^an existing unpaid invoice with a due date (\d+) days ago$/) do |days|
  @invoice = FactoryGirl.create(:invoice, id_card: @user.entity.current_id_card,
                                paid: false,
                                due_date: (Date.today - days.to_i))
end

Then(/^the invoice paid status should not have a color$/) do
  find("#paid")[:class].should_not include("green", "orange", "red")
end

Then(/^the invoice paid status should be green$/) do
  find("#paid")[:class].should include("green")
end

Then(/^the invoice paid status should be orange$/) do
  find("#paid")[:class].should include("orange")
end

Then(/^the invoice paid status should be red$/) do
  find("#paid")[:class].should include("red")
end
