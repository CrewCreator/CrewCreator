Feature: Remove Instructor
  As a admin
  I want to be able to remove an instructor,
  so that I can remove professors from managing courses

  Scenario: Admin see the option to remove an instructor
    Given I have an admin account
    And I have an instructor account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the all instructors page
    Then I should see "Remove Prof"
  
  Scenario: Admin removes an instructor
    Given I have an admin account
    And I have an instructor account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the all instructors page
    And I follow "Remove Prof"
    Then I should see "Remove User: Prof"
    Then I should see "prof@email.com"
    And I fill in "admin_password" with "password1!"
    And I press "Remove Prof"
    And I should be on the all instructors page
    Then I should see "successfully deleted"
  
  Scenario: Non-Authenticated user attempts to view the remove admin buttons
    When I am on the all instructors page
    Then I should not see "Remove"
  
  Scenario: Admin attempts to remove an instructor with wrong password
    Given I have an admin account
    And I have an instructor account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the all instructors page
    And I follow "Remove Prof"
    Then I should see "Prof"
    Then I should see "prof@email.com"
    And I fill in "admin_password" with "wrong_password2"
    And I press "Remove Prof"
    Then I should see "Remove User: Prof"