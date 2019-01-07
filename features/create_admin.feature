Feature: Create Admin
  As a admin
  I want to be able to create an admin,
  so that additional admins can setup and run courses

Scenario: Admin sees the account page
  Given I am logged in as "admin@admin.com"
  When I am on the sign in page
  Then I should see "Sign Up"
  And I should see "Log In"

Scenario: User presses the Sign Up button
  When I am on the login page
  And I follow "Sign Up"
  Then I go to the create account page
  And I should see "Account Created"