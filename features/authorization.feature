Feature: Authorization.
  As a user that has been registered on the site, I want to be able to access
  my account settings and my feed in order to enjoy new information in my feed
  and contact with my friends.

  #doc: https://docs.google.com/document/d/12juTn1Szm-TRf-sYDzVXD_soJ4fgceH70bxGV7q6of4/edit#

  #todo:
  #Scenario: Login with Twitter
  #Scenario: Login with Facebook
  #Scenario: Login with Google
  #imaginary Scenario: 10 attempts to sign in with wrong password - CAPTCHA displayed.

  Scenario: Log in to the site
    Given I am on "login" page
      And There is a user "_testuser" with password "ntcnbhjdfybt"
    When I fill in "Username" with "_testuser"
      And fill in "Password" with "ntcnbhjdfybt"
      And press "Sign in"
    Then I should be on the homepage
      And I should see "sign out"
          #page elements should be verified separately in feed view tests. presence of sign out confirms that we're logged in and no errors had happened during login.

  Scenario: Unregistered 
    Given I am on "login" page
    When I fill in "Username" with "notexists"
      And fill in "Password" with "notexists"
      And press "Sign in"
    Then I should be on "login error" page
          #replace with regexp?
      And I should see "We could not find the nickname you provided."
      And I should see "Create an account »"

  Scenario: Wrong password
    Given I am on "login" page
      And There is a user "_testuser" with password "ntcnbhjdfybt"
    When I fill in "Username" with "_testuser"
      And fill in "Password" with "unntcnbhjdfybt"
      And press "Sign in"
    Then I should be on "login error" page
          #replace with regexp?
      And I should see "The password you provided does not match the password in our system."
      And I should see "Create an account »"
    
  Scenario: Two empty fields
    Given I am on "login" page
    When I press "Sign in"
    Then I should be on the homepage
          #on Friendfeed no error is displayed. on pepyatka:
    # And I should see "Error: user undefined doesn't exist"
          #Error: Please enter username and password

  Scenario: Empty username field
    Given I am on "login" page
    When I fill in "Password" with "ntcnbhjdfybt"
      And press "Sign in"
    Then I should be on the homepage
          #on Friendfeed no error is displayed. on pepyatka:
    # And I should see "Error: user undefined doesn't exist"
          #Error: Please enter username

  Scenario: Empty password field
    Given I am on "login" page
    When I fill in "Username" with "_testuser"
      And press "Sign in"
    Then I should be on the homepage
          #on Friendfeed no error is displayed. on pepyatka:
    # And I should see "Error: user undefined doesn't exist"
          #Error: Please enter password

  Scenario: Email not verified
    Given I am on "login" page
	  And there is a user "_testuser" with password "ntcnbhjdfybt" and email "freefeed.net+unverified@gmail.com"
	  And email is not verified for "_testuser"
    When I fill in "Username" with "_testuser"
	  And fill in "Password" with "ntcnbhjdfybt"
      And press "Sign in"
    Then I should be on "Login error" page
      And I should see "Your email address has not yet been verified. <a href="/account/reverifyemail?email=freefeed.net+unverified@gmail.com" target="_top">Re-sendverification email &raquo;</a>"
#emailverification.feature starts 
		  	  
  Scenario: Reach Create account page from login error
    Given I am on "login error" page
    When I follow "Create an account »"
    Then I should be on "registration" page
