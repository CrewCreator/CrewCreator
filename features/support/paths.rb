# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/home'

    when /^the create account\s?page$/
      '/createaccount'
    
    when /^the all admin accounts\s?page$/
      '/admins'
      
    when /^the admin profile\s?page$/
      '/admin_account'
      
    when /^the course\s?page$/
      '/courses'
      
    when /^the new course\s?page$/
      '/courses/new'

    when /^the login page$/
      '/login'

    when /^the section page for course "(.*)"$/
      course_sections_path(Course.find_by_name($1).id)
      
    when /^the new section page for course "(.*)"$/
      new_course_section_path(Course.find_by_name($1))
      
    when /^the projects page for section "(.*)"$/
      section_projects_path(Section.find_by_number($1))
      
    when /^the new project page for section "(.*)"$/
      new_section_project_path(Section.find_by_number($1))

    when /^the create skill\s?page$/
      '/skills/new'
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
