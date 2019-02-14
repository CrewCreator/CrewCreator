Feature: Admin Dashboard
  As an admin
  I want to see the all the sections on the dashboard
  so that when I login it is easy to navigate to any section
  
  Scenario: Admin sees all sections
    Given I have an admin account
    And I am logged in as "admin@admin.com" with "password1!"
    And I have a course with name "any-course" and code "code-123" and description "any-description" and sections "501 502"
    And the course "any-course" has the following sections:
    | year | semester | number |
    | 2019 | Winter   | 501    |
    | 2019 | Winter   | 502    |
    | 2019 | Fall     | 501    |
    | 2019 | Spring   | 502    |
    | 2017 | Spring   | 502    |
    When I am on the home page
    Then I should see "501 Winter-2019" before "501 Fall-2019"
    And I should see "501 Fall-2019" before "502 Spring-2019"
    And I should see "502 Spring-2019" before "502 Spring-2017"
    And I should see "Winter 2019" before "any-course"
    And I should see "501 Winter-2019" before "502 Winter-2019"
    When I follow "501 Winter-2019"
    Then I should be on the projects page for section number "501" semester "Winter" year "2019"
