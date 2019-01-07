Feature: Edit Admin
  As a admin
  I want to be able to edit an existing admin,
  so that I can change my password and edit other aspects of my account

Scenario: Admin sees his edit button and clicks it
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  When I am on the all admin accounts page
  Then I should see "All Admins"
  Then I should see "Edit admin@admin.com"
  And I press "Edit admin@admin.com"
  Then I should be on the admin profile page
  
Scenario: Admin sees his admin profile
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  When I am on the all admin accounts page
  And I press "Edit admin@admin.com"
  Then I should be on the admin profile page
  Then I should see "User One Profile"
  Then I should see "User One"
  Then I should see "admin@admin.com"

Scenario: Admin edits his admin profile
  Given I have an account with name "User One" and email "admin@admin.com" and password "password"
  Given I am logged in as "admin@admin.com" with "password"
  When I am on the all admin accounts page
  And I press "Edit admin@admin.com"
  Then I should be on the admin profile page
  And I fill in "admin_name" with "New Name"
  And I fill in "admin_email" with "new@email.com"
  And I fill in "admin_password" with "new_password"
  And I fill in "admin_password_confirmation" with "new_password"
  And I press "Update Account"
  Then I should be on the admin profile page
  Then I should see "New Name"
  Then I should see "new@email.com"
  
Scenario: Non-Authenticated user attempts to access an admin profile
  Given I am on the all admin accounts page
  Then I should not see "Edit"