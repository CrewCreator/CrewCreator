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
  course = Course.create(name: name, code: code, description: description)
  course.sections.build(number: section)
end

Given /^(?:|I )have a course with name "(.*)" and code "(.*)" and description "(.*)" and sections "(.*)"$/ do |name, code, description, sections|
  sections = sections.split(" ")
  course = Course.create(name: name, code: code, description: description)
  course.save
  
  sections.each do |section|
    course.sections.create(number: section).save
  end
  visit(courses_path)
end