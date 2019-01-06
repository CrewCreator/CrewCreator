When(/^I click create the create project button$/) do
  click_on "create" 
end

Then(/^I should see a new project confirmation message$/) do
  expect(page).to have_content("")  
end
