Feature: Just testing Turnip
  Scenario: Middle-aged programmer tries turnip
    Given the integer 5
    When I add 6 to it
    Then I get 11

  Scenario:
    Then a + b = c if equal?:
    | a | b | c | equal? |
    | 1 | 2 | 4 | no     |
    | 2 | 4 | 6 | yes    |