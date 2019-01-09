require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )have a project with name "(.*)" and description "(.*)" and difficulty "(.*)" and skill "(.*)" for section "(.*)"$/ do |name, description, difficulty, skill, section|
  visit section_projects_path(Section.find_by_number(section))
  click_button "New Project"
  fill_in("name", :with => name)
  fill_in("description", :with => description)
  select(difficulty, :from => "project_difficulty")
  check(skill)
  
  click_button "Save Project"
end