Feature: Instructor can access projects they own
  As an instructor,
  I want to be able to access projects
  So that I can create, read, update, and delete content in my section
  
  Scenario: Instructor create a project
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And I have a skill with name "any-skill" and description "any-skill-description"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I am on the new project page for section "502"
    And I fill in "description" with "project-description"
    And I fill in "name" with "project-name"
    And I select "4" from "project[difficulty]"
    And I check "any-skill"
    When I press "save"
    Then I should see "project-description"
    And I should see "project-name"
    And I should see "4"
    And I should see "any-skill" 
    And I should be on the projects page for section "502"
    
  Scenario: Instructor edit a projects details
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I have a skill with name "any-skill" and description "any-skill-description"
    And I have a skill with name "new-skill" and description "new-skill-description"
    And I have a project with name "any-project-name" and description "any-project-description" and difficulty "4" and skill "any-skill" for section "502"
    And I am on the edit project page for project "any-project-name"
    And I fill in "description" with "new-project-description"
    And I fill in "name" with "new-project-name"
    And I select "2" from "project[difficulty]"
    And I check "new-skill"
    When I press "save"
    Then I should see "new-project-description"
    And I should see "new-project-name"
    And I should see "2"
    And I should see "new-skill" 
    And I should be on the projects page for section "502"
    
  Scenario: Instructor removes a project
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And I have a skill with name "any-skill" and description "any-skill-description"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I have a project with name "any-project-name" and description "any-project-description" and difficulty "4" and skill "any-skill" for section "502"
    And I am on the projects page for section "502"
    When I follow "Delete"
    Then I should be on the remove project page for project "any-project-name"
    When I confirm my password as "admin@admin.com" with password "password1!"
    Then I should see "any-project-name was successfully deleted."
    And I should not see "any-project-description"
    And I should not see "4"
    And I should not see "any-skill" 
    And I should be on the projects page for section "502"