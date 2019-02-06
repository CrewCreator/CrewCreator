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
  visit(new_course_path)
  fill_in("course_name", with: name)
  fill_in("course_code", with: code)
  fill_in("course_description", with: description)
  fill_in("section[number]", with: section)
  choose("section_semester_Spring")
  fill_in("section[year]", with: "2018")
  click_button("Save Course")
end

Given /^(?:|I )have a course with name "(.*)" and code "(.*)" and description "(.*)" and sections "(.*)"$/ do |name, code, description, sections|
  sections = sections.split(" ")
  course = Course.create(name: name, code: code, description: description)
  course.save
  if course
    sections.each do |section|
      course.sections.create(number: section, semester: "Spring", year: "2018").save
    end
  end
  visit(courses_path)
end

When /^(?:|I )update course "(.*)" with name "(.*)" and code "(.*)" and description "(.*)"$/ do |course, name, code, description|	
  Course.update(Course.find_by_code(course).id, name: name, code: code, description: description)
end	

Given /^(?:|I )have a course$/ do	

  sections = '200 501 502'.split(" ")	
  course = Course.create(name: "Software Engineering", code: "CSCE-431", description: "Anything")
  course.save
  
  sections.each do |section|
    course.sections.create(number: section, semester: "Spring", year: "2018").save
  end
  visit(courses_path)
end