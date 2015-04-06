Feature: Authorization
As a user that has been registered on the site, I want to be able to access my account settings and my feed in order to enjoy new information in my feed and contact with my friends.

Scenario: Log in to the site
  Given I am on login page
    And I am registered user
    And I have username "_testuser"
    And I have password "ntcnbhjdfybt"
  When I fill in "Username" with "_testuser"
    And fill in "Password" with "ntcnbhjdfybt"
    And press "Sign in"
  Then I should be on homepage
    And I should see "Sign out" 
#page elements should be verified separately in feed view tests. presence of sign out confirms that we're logged in and no errors had happened during login.

Scenario: Unregistered 
  Given I am on login page
    And I am unregistered user
  When I fill in "Username" with "_untestuser"
    And fill in "Password" with "ntcnbhjdfybt"
    And press "Sign in"
  Then I should be on https://freefeed.net/account/login?v=2
#replace with regexp?
    And I should see "We could not find the nickname you provided."

Scenario: Wrong password
Scenario: Remember me/Don't remember me 
#another .feature
