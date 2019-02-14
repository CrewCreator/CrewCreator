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

Given /^(?:|I )am logged in as an admin$/ do
  visit('/logout')
  Admin.create(name: "admin", email: "admin@admin.com", password: "password1!")
  visit("/sessions/new")
  fill_in("Email", with: "admin@admin.com")
  fill_in("Password", with: "password1!")
  click_button("Login")
end

Given /^(?:|I )have an admin account$/ do
  Admin.create(name: "admin", email: "admin@admin.com", password: "password1!")
end

Given /^(?:|I )have an admin account with name "(.*)" and email "(.*)" and password "(.*)"$/ do |name, email, password|
  Admin.create(name: name, email: email, password: password)
end

Given /^(?:|I )am logged in as "(.*)" with "(.*)"$/ do |email, password|
  visit('/logout')
  visit("/sessions/new")
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button("Login")
end

When /^(?:|I )enter my password as "(.*)"$/ do |password|
  fill_in("admin_password", :with => password)
end

When /^(?:|I )confirm my password as "(.*)" with password "(.*)"$/ do |email, password|
  fill_in("admin_password", :with => password)
  click_button("confirm")
end
