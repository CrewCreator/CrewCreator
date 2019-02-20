Feature: Admin Dashboard
  As an admin
  I want to see the all the sections on the dashboard
  so that when I login it is easy to navigate to any section
  
  Scenario: Admin sees all sections
    Given I have an admin account
    And I am logged in as "admin@admin.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "504 502"
    And the course "any-course" has the following sections:
    | year | semester | number |
    | 2019 | Winter   | 501    |
    | 2019 | Winter   | 502    |
    | 2019 | Fall     | 503    |
    | 2019 | Spring   | 502    |
    | 2017 | Spring   | 502    |
    When I am on the home page
    Then I should see "Winter 2019" before "Fall 2019"
    And I should see "Fall 2019" before "Spring 2019"
    And I should see "Spring 2019" before "Spring 2017"
    And I should see "Winter 2019" before "any-course"
    When I follow "501"
    Then I should be on the projects page for section number "501" semester "Winter" year "2019"
