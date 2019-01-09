Feature: user login
  As a user,
  I want to login
  So that I can use CrewCreator
  
Scenario: I create an account
  When I am on the login page
  And I follow "Sign Up"
  Then I go to the create account page
  And I should see "Create Account"
  And I fill in "admin_name" with "anything"
  And I fill in "admin_email" with "any@thing.com"
  And I fill in "admin_password" with "password1!"
  And I fill in "admin_password_confirmation" with "password1!"
  And I press "Create Account"
  Then I should be on the home page
  
Scenario: I look at the list of admins
  When I am on the home page
  And press "View Admins"
  Then I should see "All Admins"
  
Scenario: I look at the list of courses
  When I am on the home page
  And press "View Courses"
  Then I should see "All Courses"
  
Scenario: I try to login
  When I am on the home page
  And press "Log In"
  Then I should be on the login page
  When I fill in "Email" with "any@thing.com"
  And fill in "Password" with "anything"
  Then I should see "Log In"