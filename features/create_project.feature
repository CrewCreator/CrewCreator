Feature: Create Project
As a admin
I want to add projects to a course
So that students can be assigned to projects

Scenario: Admin create a project
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  Given I am on the new project page
  And I fill in "description" with "any description"
  And I fill in "name" with "any name"
  And I select "4" from "project[difficulty]"
  When I press "create"
  Then I should see "any description"
  And I should see "any name"
  And I should see "4"
  And I should be on the projects page

Scenario: Admin press new project link
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  Given I am on the projects page
  And I press "new_project"
  Then I should be on the new project page
  And should see "Name"
  And should see "Description"
  And should see "Difficulty"

Scenario: Admin presses create without filling in the form
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  Given I am on the new project page
  When I press "create"
  Then I should see "Name"
  And I should see "Description"
  And I should see "Difficulty"
  And I should be on the projects page