Feature: Admin removes course
  
  As an admin,
  I want to remove a course
  So that I can control the courses available
  
#happy paths
  Scenario: Admin removes a course
    Given I am logged in as a admin
    And I have a course
    And I am on the remove course page for course "CSCE-431"
    When I confirm my password as "admin@admin.com" with password "password1!"
    Then I should be on the courses page
    And I should see "CSCE-431 -- Software Engineering was successfully deleted."
    
#sad paths
  Scenario: User removes trys to remove
    Given I am on the courses page
    And I have a course
    Then I should see "CSCE-431"
    And I should not see "Delete"
    
  Scenario: User types in remove url
    Given I am on the courses page
    And I have a course
    And I am on the remove course page for course "CSCE-431"
    Then I should be on the new session page