Feature: Student Dashboard
  As an student
  I want to see the sections I'm apart of on the dashboard
  so that when I login it is easy to navigate to my sections
  
  Scenario: Student sees all their sections
    Given I have a student account
    And I am logged in as "student@email.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501"
    And the course "any-course" has the following sections:
    | year | semester | number |
    | 2019 | Winter   | 501    |
    | 2019 | Winter   | 502    |
    | 2019 | Fall     | 501    |
    | 2019 | Spring   | 502    |
    | 2017 | Spring   | 502    |
    And I am student "student@email.com" apart of the course "any-course" in the following sections:
    | year | semester | number |
    | 2019 | Winter   | 501    |
    | 2019 | Fall     | 501    |
    | 2017 | Spring   | 502    |
    When I am on the home page
    Then I should see "501 Winter-2019" before "501 Fall-2019"
    And I should see "501 Fall-2019" before "502 Spring-2017"
    And I should not see "502 Winter-2019"
    And I should not see "502 Spring-2019"
    When I follow "501 Winter-2019"
    Then I should be on the projects page for section number "501" semester "Winter" year "2019"
