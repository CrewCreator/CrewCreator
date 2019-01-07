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

Given /^(?:|I )am (a |an )"(.*)"$/ do |user|
  pending
  #if user == "Admin"
end

Given /^(?:|I )am logged in as "(.*)" with "(.*)"$/ do |email, password|
  visit("/sessions/new")
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end