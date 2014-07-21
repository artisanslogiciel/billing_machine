When(/^the administrator goes to the id cards administration page$/) do
  visit '/admin'
  step 'he goes to the id cards page'
end

When(/^he goes to the new id card page$/) do
  click_link 'New Id Card'
end

When(/^he adds an id card$/) do
  @new_id_card_name = "My new identity"
  fill_in "id-card-name", with: @new_id_card_name
  click_button 'Create Id card'
end

Then(/^the id card is added to the list$/) do
  page.should have_content @new_id_card_name
end

Given(/^an existing id card from the same entity$/) do
  @id_card_same_entity = FactoryGirl.create(:id_card,
      name: 'My id card', entity: @entity)
end

Given(/^an existing id card$/) do
  @id_card = FactoryGirl.create(:id_card, entity: @user.entity)
end

Given(/^an existing id card from this other entity$/) do
  @id_card_other_entity = FactoryGirl.create(:id_card,
      name: 'Other id card', entity: @other_entity)
end

When(/^he goes to the id cards page$/) do
  click_on 'Id Cards'
end

When(/^he goes back to the id cards page$/) do
  visit '/admin/id_cards'
end

Then(/^he should see the id card from his entity$/) do
  page.should have_content('My id card')
end

Then(/^he should not see the id card from another entity$/) do
  page.should have_no_content('Other id card')
end

Then(/^he doesn't see the id card's entity select field$/) do
  page.should have_no_selector '#id_card_entity_id'
end
