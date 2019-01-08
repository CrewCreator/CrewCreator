Feature: Create Admin
  As a admin
  I want to be able to create an admin,
  so that additional admins can setup and run courses

Scenario: Admin sees the account page
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  When I am on the home page
  Then I should see "CrewCreator"

Scenario: Admin creates an account
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  When I go to the create account page
  And I should see "Create Account"
  And I fill in "admin_name" with "anything"
  And I fill in "admin_email" with "any@thing.com"
  And I fill in "admin_password" with "passwordtwo"
  And I fill in "admin_password_confirmation" with "passwordtwo"
  And I press "Create Account"
  Then I should be on the home page