Feature: Edit a roster
  As an admin
  I want to be able to whitelist student emails for a section
  so that only certain students can join a section

  Scenario: Admin views emails from roster
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given section "501" roster has emails "test@test.com" and "any@any.com" 
    Given I am on the projects page for section "501"
    When I follow "Adjust Roster"
    Then I should be on the roster page for section "501"
    Then the "section_emails_attributes_0_email" field should contain "test@test.com"
    Then the "section_emails_attributes_1_email" field should contain "any@any.com"

  Scenario: Admin updates no emails to roster
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I am on the projects page for section "501"
    When I follow "Adjust Roster"
    Then I should be on the roster page for section "501"
    When I press "Update Roster"
    Then I should be on the projects page for section "501"
