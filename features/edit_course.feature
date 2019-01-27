Feature: Admin edits course
  
  As an admin,
  I want to edit a course
  So that I can change the information about the course
  
#happy paths
  Scenario: Admin updates all course feilds
    Given I am logged in as a admin
    And I have a course
    When I update course "CSCE-431" with name "Software Engineering II" and code "CSCE-432" and description "Something"
    And I am on the courses page
    Then I should see "CSCE-432"
    And I should see "Software Engineering II"
    And I should see "Something"
    
#sad paths
  Scenario: Admin updates without name
    Given I am logged in as a admin
    And I have a course
    When I update course "CSCE-431" with name "" and code "CSCE-432" and description "Something"
    And I am on the courses page
    Then I should not see "CSCE-432"
    And I should see "Software Engineering"
    And I should not see "Something"