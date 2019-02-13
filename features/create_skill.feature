Feature: Create Skill
  As an admin
  I want to be able to add a skill to the database,
  so that students can select the skills they have

  Scenario: Admin goes to skills page
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I go to the skills page
    Then I click the button create skill
    Then I should see the create skill page

  Scenario: Admin creates a skill
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I go to the create skill page
    And I fill in "skill_name" with "Android"
    And I fill in "skill_description" with "Building Android Apps"
    And I press "submit_skill"
    And I should see "Android"
    And I should see "Building Android Apps"
    And I should be on the skills page
