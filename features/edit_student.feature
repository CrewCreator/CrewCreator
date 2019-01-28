Feature: Edit Student
  As a student
  I want to be able to edit my student account,
  so that I can change my password and edit other aspects of my account

  Scenario: Student exists and navigates to his account page
    Given I have a student account
    Given I am logged in as "student@email.com" with "password1!"
    When I am on the home page
    And I follow "My Student Account"
    Then I am on the student account page for student "student@email.com"
    Then I should see "Joe's Account"
  
  Scenario: Student edits his student profile's name and email
    Given I have a student account
    Given I am logged in as "student@email.com" with "password1!"
    When I am on the student account page for student "student@email.com"
    And I fill in "student_name" with "Second Name"
    And I fill in "student_email" with "new@email.com"
    And I fill in "admin_password" with "password1!"
    And I press "Update Joe"
    Then I should be on the student account page for student "student@email.com"
    Then I should see "Second Name's Account"
    
  Scenario: Student edits his student profile's name
    Given I have a student account
    Given I am logged in as "student@email.com" with "password1!"
    When I am on the student account page for student "student@email.com"
    And I fill in "student_name" with "Third Name"
    And I fill in "admin_password" with "password1!"
    And I press "Update Joe"
    Then I should be on the student account page for student "new@email.com"
    Then I should see "Third Name's Account"
    
  Scenario: Admin attempts edits his admin profile with wrong password
    Given I have a student account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    And I fill in "admin_name" with "New Name"
    And I fill in "admin_email" with "new@email.com"
    And I fill in "admin_password" with "wrong_password"
    And I press "Update admin"
    Then I should be on the admin profile page
    Then I should see "Incorrect Password"