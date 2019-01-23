Feature: Admin removes course
  
  As an admin,
  I want to remove a course
  So that I can control the courses available
  
#happy paths
  Scenario: Admin removes a course
    Given I am logged in as an admin
    And I have a course with name "Software Engineering" and code "CSCE-431" and description "Anything" and sections "501 502"
    And I am on the courses page
    When I follow "delete_CSCE-431"
    Then I should be on the remove course page for "CSCE-431"
    When enter my password as "password1!"
    And press "Remove Software Engineering"
    Then I should be on the courses page