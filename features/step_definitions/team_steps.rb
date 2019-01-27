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
  section = Section.find_by_number(section)
  project = section.projects.create(name: "proj-name", description: "proj-description", difficulty: "4", students_rated: "0", total_interest: "0")
  project.save
  project.teams.create(name: name, version_control_link: links, production_link: links, management_link: links, scrum_location: location).save
  visit(section_projects_path(section))
end