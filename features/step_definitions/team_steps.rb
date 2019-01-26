require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )have a project for section "(.*)" with default values and team with name "(.*)" and links "(.*)" and location "(.*)"$/ do |section, name, links, location|
  visit section_projects_path(Section.find_by_number(section))
  click_button "New Project"
  fill_in("name", with: "proj-name")
  fill_in("description", with: "proj-description")
  select("4", from: "project_difficulty")
  click_button "Save Project"
  
  visit new_project_team_path(Project.find_by_name("proj-name"))
  fill_in("name", with: name)
  fill_in("version_control_link", with: links)
  fill_in("production_link", with: links)
  fill_in("management_link", with: links)
  fill_in("scrum_location", with: location)
  click_button "Create Team"
end
