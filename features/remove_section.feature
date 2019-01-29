Feature: Remove a section
  As an admin
  I want to be able to remove a section
  To clear out projects and teams and students for managing professors
  
  Scenario: Admin exists and course exists and deletes a section
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I am on the projects page for section "501"
    When I follow "remove_section_501"
    Then I should be on the remove section page for section "501"
    When I confirm my password as "admin@admin.com" with password "password1!"
    Then I should see "501 was successfully deleted."
    And I should be on the course page
   
  Scenario: Admin exists and course exists and tries deleting a section without password
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I am on the projects page for section "501"
    When I follow "remove_section_501"
    Then I should be on the remove section page for section "501"
    When I press "confirm"
    Then I should see "Incorrect Password"
    And I should see "501"
    And I should be on the remove section page for section "501"
   