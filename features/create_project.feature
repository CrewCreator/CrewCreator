Feature: Create Project
As a admin
I want to add projects to a course
So that students can be assigned to projects

Scenario: Admin create a project
  Given I am on the new project page
  And I fill in "description" with "any description"
  And I fill in "name" with "any name"
  When I press "create"
  Then I should see "any description"
  And I should see "any name"
  And I should be on the projects page

Scenario: Admin press new project linke
  Given I am on the projects page
  And I press "new_project"
  Then I should be on the new project page
  And should see "Name"
  And should see "Description"
