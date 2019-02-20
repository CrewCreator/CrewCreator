Feature: Remove a Project
  As an admin
  I want to remove projects from (a) section(s)
  so that I can alter what students are able to be assigned
  
  Scenario: Admin removes a project
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I have a skill with name "any-skill" and description "any-skill-description"
    Given I have a project with name "any-project-name" and description "any-project-description" and difficulty "4" and skill "any-skill" for section "501"
    Given I am on the projects page for section "501"
    When I follow "Delete"
    Then I should be on the remove project page for project "any-project-name"
    When I confirm my password as "admin@admin.com" with password "password1!"
    Then I should see "any-project-name was successfully deleted."
    And I should not see "any-project-description"
    And I should not see "any-skill" 
    And I should be on the projects page for section "501"
  
  Scenario: Admin confirms removing a project without password
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I have a skill with name "any-skill" and description "any-skill-description"
    Given I have a project with name "any-project-name" and description "any-project-description" and difficulty "4" and skill "any-skill" for section "501"
    Given I am on the projects page for section "501"
    When I follow "Delete"
    Then I should be on the remove project page for project "any-project-name"
    When I press "confirm"
    Then I should see "Incorrect Password"
    And I should see "any-project-description"
    And I should see "any-project-name"
    And I should see "any-skill" 
    And I should be on the remove project page for project "any-project-name"
