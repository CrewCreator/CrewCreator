require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)


# When(/^I go to the skills page$/) do
#   visit "/skills"
# end

When(/^I go create a skill$/) do
  visit "skills/new"
end

Then(/^I click the button add skill$/) do
  click_button("Add Skill")
end

Then(/^I should see the create skill page$/) do
  expect(page).to have_content("Add Skill")
end


Given /^(?:|I )have a skill with name "(.*)" and description "(.*)"$/ do |name, description|
  visit("/skills/new")
  fill_in("skill_name", :with => name)
  fill_in("skill_description", :with => description)

  click_button("Create Skill")
end


