Feature: Remove a Team
  As an admin
  I want to view information about a team
  so that I can track progress of teams
  
  Scenario: Admin views individual team
    Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description"
    Given I have a section with number "501" and semester "Fall" and year "2018"
    Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    Given I should be on the projects page for section "501"
    When I follow "team-name"
    Then I should be on the show team page for team "team-name"
    And I should see "Team: team-name"
    And I should see "http://anything.com"
  
  Scenario: Admin views all teams in a section
    Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    Given I should be on the projects page for section "501"
    When I follow "Teams"
    Then I should be on the index team page for section "501"
    And I should see "team-name"
    And I should see "Teams for Section"