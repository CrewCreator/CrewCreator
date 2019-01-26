Feature: Create Team
As an admin
I want to create teams
so that I can organize and keep track of students team progress

Scenario: Admin create a team
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
  Given I have a project for section "501" with name "project-name" and description "project-description" and difficulty "4"
  Given I am on the new team page for project "project-name"
  And I fill in "name" with "team-name"
  And I fill in "version_control_link" with "http://vcl.com"
  And I fill in "production_link" with "http://pl.com"
  And I fill in "management_link" with "http://ml.com"
  And I fill in "scrum_location" with "here"
  When I press "submit-team"
  Then I should see "team-name"
  And I should see "http://vcl.com"
  And I should see "http://pl.com"
  And I should see "http://ml.com"
  And I should be on the projects page for section "501"

Scenario: Admin press add team link
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
  Given I have a project for section "501" with name "project-name" and description "project-description" and difficulty "4"
  Given I am on the projects page for section "501"
  And I follow "add-team"
  Then I should be on the new team page for project "project-name"
  And I should see "Name"
  And I should see "Version control link"
  And I should see "Production link"
  And I should see "Management link"

Scenario: Admin presses create team without filling in the form
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
  Given I have a project for section "501" with name "project-name" and description "project-description" and difficulty "4"
  Given I am on the new team page for project "project-name"
  When I press "submit-team"
  Then I should see "Name"
  And I should see "Version control link"
  And I should see "Production link"
  And I should see "Management link"
  And I should see "prohibited this project from being saved"
  And I should be on the teams page for project "project-name"
