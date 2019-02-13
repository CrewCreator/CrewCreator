Feature: Create Admin
  As a admin
  I want to be able to create an admin,
  so that additional admins can setup and run courses

Scenario: Admin sees the account page
  Given I have an admin account
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the home page
  Then I should see "admin@admin.com"

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
  Then I should be on the all admins account page

#add random user can't make an admin account