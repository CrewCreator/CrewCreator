Feature: Instructor has admin privilege
  As an instructor,
  I want to have access to sections
  So that I can manage sections I am in charge of
  
  Scenario: Instructor creates section
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    When I am on the new section page for course "code-123"
    And I fill in "number" with "201"
    And I choose "fall"
    And I fill in "year" with "2018"
    And I press "Create"
    Then I should be on the course page
  
  Scenario: Instructor exists edits a section
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And I am on the projects page for section "502"
    When I follow "edit_section_502"
    And I fill in "section[number]" with "123"
    And I press "Update Section"
    Then I should see "Section 123 was successfully updated."
    And I should be on the projects page for section "123"
    
  Scenario: Instructor views emails from roster
    Given I have an instructor account
    And I am logged in as "prof@email.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    And section "502" roster has emails "test@test.com" and "any@any.com" 
    And I am on the projects page for section "502"
    When I follow "Adjust Roster"
    Then I should be on the roster page for section "502"
    And the "section_emails_attributes_0_email" field should contain "test@test.com"
    And the "section_emails_attributes_1_email" field should contain "any@any.com"
    
  Scenario: Instructor deletes a section
    Given I have an instructor account
    Given I am logged in as "prof@email.com" with "password1!"
    Given I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And Instructor "prof@email.com" has made section "502" for course "code-123"
    Given I am on the projects page for section "502"
    When I follow "remove_section_502"
    Then I should be on the remove section page for section "502"
    When I confirm my password as "prof@email.com" with password "password1!"
    Then I should see "502 was successfully deleted."
    And I should be on the course page  