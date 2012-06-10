Feature: Codebreaker wins game

  As a codebreaker
  I want to be congratulated when I win the game
  So that I know that I won the game
  And that I feel good about myself for doing so
	
  Scenario: win game
    Given the secret code is "1234"
    When I guess "1234"
    Then I should see "++++"
    And I should see "You won!!!"

