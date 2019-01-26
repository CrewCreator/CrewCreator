require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )create a course with name "(.*)" and code "(.*)" and description "(.*)" and section "(.*)"$/ do |name, code, description, section|
  visit new_course_path
  fill_in("course_name", :with => name)
  fill_in("course_code", :with => code)
  fill_in("course_description", :with => description)
  fill_in("section_number", :with => section)
  click_button "Save Course"
end

Given /^(?:|I )have a course with name "(.*)" and code "(.*)" and description "(.*)" and sections "(.*)"$/ do |name, code, description, sections|
  sections = sections.split(" ")
  visit new_course_path
  fill_in("course_name", :with => name)
  fill_in("course_code", :with => code)
  fill_in("course_description", :with => description)
  fill_in("section_number", :with => sections[0])
  click_button "Save Course"
  
  if sections.size >= 1
    sections[1..sections.size].each do |section|
      visit courses_path
      click_link "add_section_to_#{code}"
      fill_in("number", :with => section)
      click_button "Create Section"
    end
  end
end

Given /^(?:|I )have a course$/ do
  
  if page.has_content?("Logged in as admin@admin.com.")
    flag = true
    puts("Error")
  else
    flag = false
    visit("/createaccount")
    fill_in("admin_name", :with => "admin")
    fill_in("admin_email", :with => "admin@admin.com")
    fill_in("admin_password", :with => "password1!")
    fill_in("admin_password_confirmation", :with => "password1!")
    click_button("Create Account")
    visit("/sessions/new")
    fill_in("Email", :with => "admin@admin.com")
    fill_in("Password", :with => "password1!")
    click_button("Login")
  end
  
  sections = '200 501 502'.split(" ")
  visit new_course_path
  fill_in("course_name", :with => 'Software Engineering')
  fill_in("course_code", :with => 'CSCE-431')
  fill_in("course_description", :with => 'Anything')
  fill_in("section_number", :with => sections[0])
  click_button "Save Course"
  
  if sections.size >= 1
    sections[1..sections.size].each do |section|
      click_link "add_section_to_CSCE-431"
      fill_in("number", :with => section)
      click_button "Create Section"
    end
  end
  
  if !flag
    visit("/logout")
    visit("/courses")
  end
end
  