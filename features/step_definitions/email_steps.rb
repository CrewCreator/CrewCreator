require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|The )section "(.*)" roster has emails "(.*)" and "(.*)"$/ do |number, email1, email2|
  section = Section.find_by_number(number)
  section.emails << Email.create(email: email1)
  section.emails << Email.create(email: email2)
end