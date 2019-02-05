Feature: Edit a Team
  As an admin
  I want to be able to manage users, links, and content associated with the team
  so that users feel comfortable with their teams
  
#happy paths
  Scenario: Admin edit all teams details
    Given I have an admin account
    And I am logged in as "admin@admin.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And I have an account with name "Student" and email "email@email.com" and password "password1!"
    And I have the email "email@email.com" on the roster for section "501" and course "code-123"
    And I am on the edit team page for team "team-name"
    When I fill in "name" with "new-team-name"
    And I fill in "version_control_link" with "http://new.com"
    And I fill in "production_link" with "http://new.com"
    And I fill in "management_link" with "http://new.com"
    And I check "email@email.com"
    And I press "submit-team"
    Then I should see "new-team-name"
    And I should see "http://new.com"
    And I should be on the show team page for team "new-team-name"
  
  Scenario: Admin press edit team link
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    Given I am on the show team page for team "team-name"
    When I follow "Edit Team"
    Then I should be on the edit team page for team "team-name"
    And I should see "Name"
    And I should see "Version control link"
    And I should see "Production link"
    And I should see "Management link"
  
#sad paths
  Scenario: Admin presses update team with invalid details
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    Given I am on the edit team page for team "team-name"
    When I fill in "name" with ""
    When I press "submit-team"
    Then I should see "Name"
    And I should see "Version control link"
    And I should see "Production link"
    And I should see "Management link"
    And I should see "prohibited this project from being saved"
    And I should be on the patch team page for team "team-name"
