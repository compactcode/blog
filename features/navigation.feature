Feature: Users can navigate around the various pages
  In order to read all the awesome content
  As a compact code reader
  I should be able to navigate to all the important sections of the site.

  Scenario: Title links to the home page
    Given I am on the about page
    And I follow "compact code" within "h1#title"
    Then I should be on the home page