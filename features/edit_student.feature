Feature: Edit Student
  As a student
  I want to be able to edit my student account,
  so that I can change my password and edit other aspects of my account

  Scenario: Student exists and navigates to his account page
    Given I have a student account
    And I am logged in as "student@email.com" with "password1!"
    When I am on the home page
    And I follow "My Student Account"
    Then I am on the student account page for student "student@email.com"
    And I should see "Joe's Account"
  
  Scenario: Student edits his student profile's name and email
    Given I have a student account
    Given I am logged in as "student@email.com" with "password1!"
    When I update student "student@email.com" with name "Second Name" and email "new@email.com"
    And I am on the student account page for student "new@email.com"
    Then I should see "Second Name's Account"
    
  Scenario: Student edits his student profile's name
    Given I have a student account
    And I am logged in as "student@email.com" with "password1!"
    When I update student "student@email.com" with name "Third Name" and email "student@email.com"
    And I am on the student account page for student "student@email.com"
    Then I should see "Third Name's Account"
    
  Scenario: Student attempts edits his student profile with wrong password
    Given I have a student account
    And I am logged in as "student@email.com" with "password1!"
    When I am on the student account page for student "student@email.com"
    And I fill in "student_name" with "New Name"
    And I fill in "student_email" with "new@email.com"
    And I confirm my password as "student@email.com" with password "wrong_password"
    Then I should be on the student account page for student "student@email.com"
    And I should see "Incorrect Password"