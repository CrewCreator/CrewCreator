Feature: Create Project
As a admin
I want to add projects to a course
So that students can be assigned to projects

Scenario: Admin create a project
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "any-code" and description "any-description" and sections "501"
  Given I am on the new project page for section "501"
  And I fill in "description" with "project-description"
  And I fill in "name" with "project-name"
  And I select "4" from "project[difficulty]"
  When I press "create"
  Then I should see "project-description"
  And I should see "project-name"
  And I should see "4"
  And I should be on the projects page for section "501"

Scenario: Admin press new project link
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "any-code" and description "any-description" and sections "501"
  Given I am on the projects page for section "501"
  And I press "new_project"
  Then I should be on the new project page for section "501"
  And should see "Name"
  And should see "Description"
  And should see "Difficulty"
  And should see "Skills"

Scenario: Admin presses create without filling in the form
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "any-code" and description "any-description" and sections "501"
  Given I am on the new project page for section "501"
  When I press "create"
  Then I should see "Name"
  And should see "Description"
  And should see "Difficulty"
  And should see "Skills"
  And I should be on the projects page for section "501"
