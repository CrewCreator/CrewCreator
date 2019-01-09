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

When(/^I go create a team/) do
  visit "teams/new"
end

Then(/^I click the button create team$/) do
  click_button("Add a New Team")
end

Then(/^I should see the create team page$/) do
  expect(page).to have_content("Create a Team")
end




