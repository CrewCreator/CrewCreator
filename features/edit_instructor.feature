Feature: Edit Instructor
  As an instructor
  I want to be able to edit an existing instructor,
  so that I can change my password and edit other aspects of my account
  
  Scenario: Instructor sees his instructor profile
    Given I have an instructor account
    Given I am logged in as "prof@email.com" with "password1!"
    When I am on the instructor profile page for "prof@email.com"
    Then I should see "Prof's Details"
    Then I should see "Prof"
    Then I should see "prof@email.com"
  
  Scenario: Instructor edits his instructor profile's name and email
    Given I have an instructor account
    Given I am logged in as "prof@email.com" with "password1!"
    When I am on the instructor profile page for "prof@email.com"
    And I fill in "instructor_name" with "New Name"
    And I fill in "instructor_email" with "new@email.com"
    And I fill in "admin_password" with "password1!"
    And I press "Update Prof"
    Then I should be on the instructor profile page for "prof@email.com"
    Then I should not see "Incorrect Password"
    
  Scenario: Instructor edits his instructor profile's name
    Given I have an instructor account
    Given I am logged in as "prof@email.com" with "password1!"
    When I am on the instructor profile page for "prof@email.com"
    And I fill in "instructor_name" with "New Name"
    And I fill in "admin_password" with "password1!"
    And I press "Update Prof"
    Then I should be on the instructor profile page for "prof@email.com"
    Then I should not see "Incorrect Password"
    
  Scenario: Instructor attempts edits his instructor profile with wrong password
    Given I have an instructor account
    Given I am logged in as "prof@email.com" with "password1!"
    When I am on the instructor profile page for "prof@email.com"
    And I fill in "instructor_name" with "New Name"
    And I fill in "instructor_email" with "new@email.com"
    And I fill in "admin_password" with "wrong_password"
    And I press "Update Prof"
    Then I should be on the instructor profile page for "prof@email.com"
    Then I should see "Incorrect Password"