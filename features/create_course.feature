Feature: admin create class
  
  As an admin
  So that I can manage groups of students and projects
  I want to create a class
  
Scenario: I create a class
  When I am on the courses page
  And I press "Create Class"
  Then I should see "Create Class"
  