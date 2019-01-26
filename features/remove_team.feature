Feature: Remove a Team
As an admin
I want to delete a team
so that I can properly manage a project's life-cycle

Scenario: Admin removes a team
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
  Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
  Given I am on the show team page for team "team-name"
  When I follow "Delete Team"
  Then I should be on the remove team page for team "team-name"
  When I confirm my password as "admin@admin.com" with password "password1!"
  Then I should see "team-name was successfully deleted."
  And I should not see "http://new.com"
  And I should be on the projects page for section "501"

Scenario: Admin deletes with wrong password
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
  Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
  Given I am on the show team page for team "team-name"
  When I follow "Delete Team"
  Then I should be on the remove team page for team "team-name"
  When I press "confirm"
  Then I should see "Incorrect Password"
  And I should see "team-name"
  And I should see "Remove Team:"
  And I should be on the remove team page for team "team-name"
