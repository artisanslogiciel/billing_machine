Then(/^he doesn't see the filter for entity$/) do
  page.should have_no_selector '#q_entity_id'
end
