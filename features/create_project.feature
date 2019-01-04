Feature: Create Project
As a admin
I want to add projects to a course
So that students can be assigned to projects

Scenario: Admin create a project
  Given I am on the project creation page
  And I fill in "Description" with "anything"
  And I fill in "Name" with "anything"
  When I click create the create project button
  Then I should see a project creation confirmation message
