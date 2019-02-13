Feature: Create Instructor
  As an admin,
  I want to be able to create instructors
  so that I can have psuedo-admin users
  
  Scenario: Instructor can login
    Given I have an instructor account
    And I am on the login page
    When I fill in "Email" with "prof@email.com"
    And I fill in "password" with "password1!"
    And I press "Login"
    Then I should see "Logged in"
  
  Scenario: Admin create an instructor
    Given I am logged in as an admin
    And I am on the home page
    When I follow "View Instructors"
    And follow "Create instructor"
    And I should see "Create Instructor Account"
    And I fill in "instructor_name" with "anything"
    And I fill in "instructor_email" with "any@thing.com"
    And I fill in "instructor_password" with "password2@"
    And I fill in "instructor_password_confirmation" with "password2@"
    And I press "Create Account"
    Then I should be on the instructors page
    And I should see "any@thing.com"
  