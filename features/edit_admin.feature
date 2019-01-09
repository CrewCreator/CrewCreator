Feature: Edit Admin
  As a admin
  I want to be able to edit an existing admin,
  so that I can change my password and edit other aspects of my account

Scenario: Admin exists and navigates to his account page
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the all admin accounts page
  Then I should see "User One"
  When I am on the admin profile page
  Then I should see "User One's Account"
  
Scenario: Admin sees his admin profile
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the admin profile page
  Then I should see "User One's Account"
  Then I should see "User One"
  Then I should see "admin@admin.com"

Scenario: Admin edits his admin profile's name and email
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the admin profile page
  And I fill in "admin_name" with "New Name"
  And I fill in "admin_email" with "new@email.com"
  And I fill in "admin_password" with "password1!"
  And I press "Update Account"
  Then I should be on the all admin accounts page
  Then I should see "New Name"
  Then I should see "new@email.com"
  
Scenario: Admin edits his admin profile's name
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the admin profile page
  And I fill in "admin_name" with "New Name"
  And I fill in "admin_password" with "password1!"
  And I press "Update Account"
  Then I should be on the all admin accounts page
  Then I should see "New Name"
  Then I should see "admin@admin.com"
  
Scenario: Admin attempts edits his admin profile with wrong password
  Given I have an account with name "User One" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the admin profile page
  And I fill in "admin_name" with "New Name"
  And I fill in "admin_email" with "new@email.com"
  And I fill in "admin_password" with "wrong_password"
  And I press "Update Account"
  Then I should be on the admin profile page
  Then I should see "Incorrect Password"
  
Scenario: Non-Authenticated user attempts to access an admin profile
  When I am on the admin profile page
  Then I should not see "Update Account"
  Then I should see "Login"