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

Given /^(?:|I )am (a |an ) "(.*)"$/ do |user|
  pending
  #if user == "Admin"
end

Given /^(?:|I )have an account with name "(.*)" and email "(.*)" and password "(.*)"$/ do |name, email, password|
  visit("/createaccount")
  fill_in("admin_name", :with => name)
  fill_in("admin_email", :with => email)
  fill_in("admin_password", :with => password)
  fill_in("admin_password_confirmation", :with => password)
  click_button("Create Account")
end

Given /^(?:|I )am logged in as "(.*)" with "(.*)"$/ do |email, password|
  visit("/sessions/new")
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end

When /^(?:|I )confirm my password as "(.*)" with password "(.*)"$/ do |email, password|
  fill_in("admin_password", :with => password)
  click_button("confirm")
end
