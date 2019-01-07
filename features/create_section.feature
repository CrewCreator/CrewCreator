# feature/create_section.feature

Feature: Admin creates a section
  As an Admin
  I want to create a section 
  So that projects and students can be added to this section of a course

Feature: Section numbers are unique
  As an Admin
  I want a unique section number
  So that my section is identifiable in the course for my group of projects and students

# TODO: Need to fix to be syntactically similar to create course tests
Scenario: User creates a new section
  When I have created a course
  And I add a section "501"
  And I press "Add Section Number"
  Then I should see "Section 501" under "My Courses"
  But If I add section "801"
  And That section already exists
  Then I should see "ERROR: Section Number already used in course!"
  Then I should be able to enter a new section number "689"
  Then I should see "Section 689" under "My Courses"
  