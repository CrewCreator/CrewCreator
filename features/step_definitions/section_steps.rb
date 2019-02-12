require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end 
end 
World(WithinHelpers)

Given /the course "(.*)" has the following sections/ do |course_name, sections_table|
  course = Course.find_by_name(course_name)
  sections_table.hashes.each do |section|
    course.sections.create!(section) 
  end
end

Given /^(?:|I )am student "(.*)" apart of the course "(.*)" in the following sections/ do |student_email, course_name, sections_table|
  course = Course.find_by_name(course_name)
  student = Student.find_by_email(student_email)
  sections_table.hashes.each do |section_hash|
    section = Section.find_by(year: section_hash[:year], semester: section_hash[:semester], number: section_hash[:number])
    section.students << student
  end
end
