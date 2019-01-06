Feature: admin create class
  
  As an admin
  So that I can manage groups of students and projects
  I want to create a class
  
Scenario: I click on create a class link
  When I am on the courses page
  And I press "Create Course"
  Then I should be on the new course page
  
Scenario: I create a class
  When I am on the new course page
  And I fill in "course_name" with "Intro to Engineering"
  And I fill in "course_code" with "ENGR 111"
  And I fill in "course_description" with "First engineering course a A&M"
  And I press "submit_new_course"
  Then I should see "ENGR 111"
  And I should see "Intro to Engineering"
  And I should see "First engineering course a A&M"