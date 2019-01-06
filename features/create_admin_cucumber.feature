#feature/create_admin_cucumber.feature

Feature: Create Admin
As a admin
I want to be able to create an admin,
so that additional admins can setup and run courses

Scenario: User sees the Create Account Page
When I go to the createaccount page
Then I should see "Create Account"

Scenario: User presses the Create Account Button
When I press "Create Account"
Then I go to the account_profile page
Then I should see "Account Created"