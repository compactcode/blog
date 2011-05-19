Feature: Users can navigate around the various pages
  In order to read all the awesome content
  As a compact code reader
  I should be able to navigate to all the important sections of the site.

  Scenario: The title links to the home page
    Given I am on the about page
    And I follow "compact code" within "header"
    Then I should be on the home page

  Scenario: The about page links to the home page
    Given I am on the about page
    And I follow "Home" within "nav"
    Then I should be on the home page

  Scenario: The home page links to the about page
    Given I am on the home page
    And I follow "About" within "nav"
    Then I should be on the about page

  Scenario: The home page links to the arhives page
    Given I am on the home page
    And I follow "Archives" within "nav"
    Then I should be on the archive page
