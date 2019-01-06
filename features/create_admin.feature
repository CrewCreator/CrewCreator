Feature: Create Admin
  As a admin
  I want to be able to create an admin,
  so that additional admins can setup and run courses

Scenario: User sees the account page
  When I am on the create account page
  Then I should see "Sign Up"
  And I should see "Log In"

Scenario: User presses the Sign Up button
  When I am on the create account page
  And I follow "Sign Up"
  Then I go to the account_profile page
  And I should see "Account Created"