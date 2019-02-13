Feature: Edit Admin
  As a admin
  I want to be able to edit an existing admin,
  so that I can change my password and edit other aspects of my account

  Scenario: Admin exists and navigates to his account page
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    Then I should see "admin"
    When I am on the admin profile page
    Then I should see "admin Details"
    
  Scenario: Admin sees his admin profile
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    Then I should see "admin Details"
    Then I should see "admin"
    Then I should see "admin@admin.com"
  
  Scenario: Admin edits his admin profile's name and email
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    And I fill in "admin_name" with "New Name"
    And I fill in "admin_email" with "new@email.com"
    And I fill in "admin_password" with "password1!"
    And I press "Update admin"
    Then I should be on the admin profile page
    Then I should not see "Incorrect Password"
    
  Scenario: Admin edits his admin profile's name
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    And I fill in "admin_name" with "New Name"
    And I fill in "admin_password" with "password1!"
    And I press "Update admin"
    Then I should be on the admin profile page
    Then I should not see "Incorrect Password"
    
  Scenario: Admin attempts edits his admin profile with wrong password
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    When I am on the admin profile page
    And I fill in "admin_name" with "New Name"
    And I fill in "admin_email" with "new@email.com"
    And I fill in "admin_password" with "wrong_password"
    And I press "Update admin"
    Then I should be on the admin profile page
    Then I should see "Incorrect Password"
    
  Scenario: Non-Authenticated user attempts to access an admin profile
    When I am on the admin profile page
    Then I should not see "Update admin"
    Then I should see "Login"