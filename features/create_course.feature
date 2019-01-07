Feature: admin create class
  
  As an admin
  So that I can manage groups of students and projects
  I want to create a class
  
Scenario: Admin clicks on create a class link
  When I am on the courses page
  And I press "Create Course"
  Then I should be on the new course page
  And I should see "Course Name"
  And I should see "Code"
  And I should see "Name"
  
Scenario: Admin creates a class
  When I am on the new course page
  And I fill in "course_name" with "any name"
  And I fill in "course_code" with "any code"
  And I fill in "course_description" with "any description"
  And I press "submit_new_course"
  Then I should see "successfully"
  And I should see "any name"
  And I should see "any code"
  And I should see "any description"
  And I should be on the courses page