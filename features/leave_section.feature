Feature: Leave a section
  As a student
  I want to join or leave sections
  so that I can control what sections I'm apart of
  
  Scenario: Student leaves a section that they are in
    Given I have a student account
    And I am logged in as "student@email.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And sections "501" roster has emails "student@email.com" and "any@any.com" 
    And I am on the projects page for section "501"
    When I follow "Join Section"
    Then I should see "You've successfully joined section 501"
    And I should be on the projects page for section "501"
    When I follow "Leave Section"
    Then I should see "You've successfully left section 501"
    And I should be on the projects page for section "501"
