# feature/create_section.feature

Feature: Admin creates a section
  As an Admin
  I want to create a section 
  So that projects and students can be added to this section of a course

Scenario: Admin creates section
  Given I have an account with name "One User" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the new section page for course "Software Engineering"
  And I fill in "number" with "1234"
  When I press "Create"
  Then I should be on the course page
  
Scenario: Admin creates section with invalid input
  Given I have an account with name "One User" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the new section page for course "Software Engineering"
  And I fill in "number" with "this is wrong"
  When I press "Create"
  Then I should be on the new section page
  
Scenario: Admin presses create without filling in the form
  Given I have an account with name "One User" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the new section page for course "Software Engineering"
  When I press "Create"
  Then I should see "Number"
  And I should be on the new section page
  
Scenario: Admin presses new section link
  Given I have an account with name "One User" and email "admin@admin.com" and password "password1!"
  Given I am logged in as "admin@admin.com" with "password1!"
  When I am on the course page
  When I follow "Add Section" with first course
  Then I should be on the new section page for course "Software Engineering"
  And I fill in "number" with "any number"
  When I press "Create" 
  Then I should be on the course page
  
  