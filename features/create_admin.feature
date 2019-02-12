Feature: Create Admin
  As a admin,
  I want to be able to create an admin
  so that additional admins can setup and run courses

Scenario: Admin sees the account page
  Given I have an admin account
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the home page
  Then I should see "Logged in as admin@admin.com"

Scenario: Admin creates an account
  Given I have an admin account
  Given I am logged in as "admin@admin.com" with "password1!"
  When I go to the create admin page
  And I should see "Create Admin Account"
  And I fill in "admin_name" with "anything"
  And I fill in "admin_email" with "any@thing.com"
  And I fill in "admin_password" with "password2@"
  And I fill in "admin_password_confirmation" with "password2@"
  And I press "Create Account"
  Then I should be on the home page
  And I should see "any@thing.com"
  
Scenario: Not logged in user tries to make an admin account
  When I go to the create admin page
  Then I should be on the new session page