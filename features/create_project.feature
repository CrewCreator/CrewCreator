Feature: Create Project
As a admin
I want to add projects to a course
So that students can be assigned to projects

Scenario: Admin create a project
  Given I am on the new project page
  And I fill in "description" with "anything"
  And I fill in "name" with "anything"
  When I press "create"
  Then I should see a new project confirmation message
