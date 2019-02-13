Feature: Instructor can access teams
  As an Instructor,
  I want to be able to access teams
  So that I can manage team in my sections
  
  Scenario: Instructor creates a team
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I have a project for section "502" with name "project-name" and description "project-description" and difficulty "4"
    And I am on the new team page for project "project-name"
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
    And I should be on the projects page for section "502"
    
  Scenario: Instructor edit all teams info
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I have a project for section "502" with default values and team with name "team-name" and links "http://anything.com" and location "any"
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
  
  Scenario: Instructor removes a team
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And Instructor "prof@email.com" has made section "501" for course "code-123"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And I am on the show team page for team "team-name"
    When I follow "Delete Team"
    Then I should be on the remove team page for team "team-name"
    When I confirm my password as "admin@admin.com" with password "password1!"
    Then I should see "team-name was successfully deleted."
    And I should not see "http://new.com"
    And I should be on the projects page for section "501"
    
  Scenario: Instructor views individual team
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And Instructor "prof@email.com" has made section "501" for course "code-123"
    And I have a project for section "501" with default values and team with name "team-name" and links "http://anything.com" and location "any"
    And I should be on the projects page for section "501"
    When I follow "team-name"
    Then I should be on the show team page for team "team-name"
    And I should see "Team: team-name"
    And I should see "http://anything.com"