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