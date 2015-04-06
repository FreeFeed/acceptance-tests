Feature: Authorization
As a user that has been registered on the site, I want to be able to access my account settings and my feed in order to enjoy new information in my feed and contact with my friends.

#pages: Login (home), Login error (/account/login?v=2)
#todo:
#Scenario: Login with Twitter
#Scenario: Login with Facebook
#imaginary Scenario: 10 attempts to sign in with wrong password - CAPTCHA displayed.


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
#placeholder url
    And I should see "We could not find the nickname you provided."
    And I should see "New to FreeFeed? Create an account »".

Scenario: Wrong password
  Given I am on login page
    And I am registered user
  When I fill in "Username" with "_testuser"
    And fill in "Password" with "unntcnbhjdfybt"
    And press "Sign in"
  Then I should be on https://freefeed.net/account/login?v=2
#replace with regexp?
#placeholder url
    And I should see "The password you provided does not match the password in our system."
    And I should see "New to FreeFeed? Create an account »".
    
Scenario: Two empty fields
  Given I am on login page
  When I press "Sign in"
  Then I should be on https://freefeed.net/
    And I should see "Error: user undefined doesn't exist"
#Error: Please entery username and password

Scenario: Empty username field
  Given I am on login page
  When I fill in "Password" with "ntcnbhjdfybt"
    And press "Sign in"
  Then I should be on https://freefeed.net/
    And I should see "Error: user undefined doesn't exist"
#Error: Please enter username

Scenario: Empty password field
  Given I am on login page
  When I fill in "Username" with "_testuser"
    And press "Sign in"
  Then I should be on https://freefeed.net/
    And I should see "Error: user _testuser doesn't exist"

Scenario: Reach Create account page from login error
  Given I am on login error page
  When I press "Create an account"
    And press "Sign in"
  Then I should be on https://freefeed.net/account/create
#placeholder url
