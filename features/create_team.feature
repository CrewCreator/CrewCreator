Feature: Create Team
  As an admin
  I want to be able to add a team to the database,
  so that students form teams after selecting which projects they want to do

  Scenario: Admin goes to teams page
    When I go to the teams page
    Then I click the button create team
    Then I should see the create team page

  Scenario: Admin creates a team
    When I go to the create team page
    And I fill in "team_name" with "Crew Creator"
    And I fill in "team_description" with "Best Team Ever!!"
    And I press "submit_team"
#    Then I should see "successfully"
    And I should see "Crew Creator"
    And I should see "Best Team Ever!!"
    And I should be on the teams page
