Feature: Edit a Team
  As an admin
  I want to be able to manage users, links, and content associated with the team
  so that users feel comfortable with their teams
  
#happy paths
  Scenario: Admin edit all teams info
    Given I have an admin account
    And I am logged in as "admin@admin.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And I have an account with name "Student" and email "email@email.com" and password "password1!"
    And I am on the edit team page for team "team-name"
    When I fill in "name" with "new-team-name"
    And I fill in "version_control_link" with "http://new.com"
    And I fill in "production_link" with "http://new.com"
    And I fill in "management_link" with "http://new.com"
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
    
  Scenario: Admin adds a student to the team
    Given I have an admin account
    And I have a student account
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And section "501" roster has emails "student@email.com" and "any@any.com"
    And I am logged in as "student@email.com" with "password1!"
    And I am on the projects page for section "501"
    And I follow "Join Section"
    And I am logged in as "admin@admin.com" with "password1!"
    And I am on the edit team page for team "team-name"
    Then I should see "student@email.com"
    When I check "student@email.com"
    And press "submit-team"
    Then I should be on the show team page for team "team-name"
    And I should see "Joe"
    
  Scenario: Admin removes a student from the team
    Given I have an admin account
    And I have a student account
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And section "501" roster has emails "student@email.com" and "any@any.com"
    And I am logged in as "student@email.com" with "password1!"
    And I am on the projects page for section "501"
    And I follow "Join Section"
    And I am logged in as "admin@admin.com" with "password1!"
    And I am on the edit team page for team "team-name"
    Then I should see "student@email.com"
    When I check "student@email.com"
    And I am on the edit team page for team "team-name"
    And I uncheck "student@email.com"
    And press "submit-team"
    Then I should be on the show team page for team "team-name"
    And I should not see "Joe"
    
  
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
    And I should see "prohibited this form from being saved"
    And I should be on the patch team page for team "team-name"
