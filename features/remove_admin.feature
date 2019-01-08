Feature: Remove Admin
  As a admin
  I want to be able to remove an existing admin,
  so that I can remove professors from managing courses

Scenario: Admin exists and sees the option to delete other admins
  Given I have an account with name "User One" and email "admin1@admin.com" and password "password"
  Given I have an account with name "User Two" and email "admin2@admin.com" and password "password"
  Given I am logged in as "admin1@admin.com" with "password"
  When I am on the all admin accounts page
  Then I should see "Removal"
  
Scenario: Admin attempts to remove another admin
  Given I have an account with name "User One" and email "admin1@admin.com" and password "password"
  Given I have an account with name "User Two" and email "admin2@admin.com" and password "password"
  Given I am logged in as "admin1@admin.com" with "password"
  When I am on the all admin accounts page
  And I follow "Remove User Two"
  When I am on the remove admin page for email "admin2@admin.com"

Scenario: Admin confirms the removal of another admin
  Given I have an account with name "User One" and email "admin1@admin.com" and password "password"
  Given I have an account with name "User Two" and email "admin2@admin.com" and password "password"
  Given I am logged in as "admin1@admin.com" with "password"
  When I am on the remove admin page
  Then I should see "User Two"
  Then I should see "admin2@admin.com"
  And I fill in "admin_password" with "password"
  And I press "Remove User Two"
  Then I am on the all admin accounts page
  Then I should not see "User Two"

Scenario: Non-Authenticated user attempts to view the remove admin buttons
  When I am on the all admin accounts page
  Then I should not see "Remove"

Scenario: Admin attempts edits his admin profile with wrong password
  Given I have an account with name "User One" and email "admin1@admin.com" and password "password"
  Given I have an account with name "User Two" and email "admin2@admin.com" and password "password"
  Given I am logged in as "admin1@admin.com" with "password"
  When I am on the remove admin page
  And I fill in "admin_password" with "wrong_password"
  And I press "Remove User Two"
  Then I am on the remove admin page
  Then I should see "Incorrect Password"