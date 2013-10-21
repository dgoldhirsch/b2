Feature: When a non-super user signs into the app, he is directed
  to the page (index) of his customers.

  Scenario:
    Given a user
    When I sign in
    Then I should be on the customers page