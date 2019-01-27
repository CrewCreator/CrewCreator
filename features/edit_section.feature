Feature: Edit a section
  As an admin
  I want to edit a section
  so that the section number for the course and projects is updated
  
  Scenario: Admin exists and course exists and want to change section number
    Given I have an admin account
    Given I am logged in as "admin@admin.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    Given I am on the projects page for section "501"
    When I follow "edit_section_501"
    And I fill in "section[number]" with "123"
    When I press "Update Section"
    Then I should see "Section 123 was successfully updated."
    And I should be on the projects page for section "123"