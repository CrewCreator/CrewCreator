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
  And I fill in "admin_password" with "this"
  And I fill in "admin_password_confirmation" with "this"
  And I press "Create Account"
  Then I should be on the home page