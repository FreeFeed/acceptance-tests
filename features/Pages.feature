Feature: Page elements.
  As a user I want to be able to see all page elements where they should be.

  #Home feed
  #Direct messages
  #My subscriptions
  #Friends
  #Groups
  #Settings
  #Search, advanced search
  #Saved searches
  #reduced footer: ToS + PP (registration) leads to correct.
  #Footer
  #tools
  #settings
  #email/im/desktop notifications
  #done Home not logged
  #done Login
  #done Login error
  #done Registration

  Scenario: Home page, not logged in
    Given I am on the homepage
     Then I should see "Join FreeFeed + fiend your friends with one click via:"
      And I should see "or sign up with your email address"
	  And I should see "Already have an account?"
      And I should see "Username"
      And I should see "Password"
	  And I should see "Created an account via Google, Facebook, or Twitter? Sign in here"
	  And I should see "Join FreeFeed or sign in to get started"
      And I should see footer
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see a list of my groups
      And I should not see "Browse/edit groups"

  Scenario: Sign in page (from Home page)
    Given I am on the homepage
     When I follow "Sign In"
     Then I should be on "login" page
      And I should see "Already have an account?"
      And I should see "Created an account via Google, Facebook, or Twitter? Sign in here"
      And I should see "Username"
      And I should see "Password"
      And I should see "Sign In" button
      And I should see a footer
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see a list of my groups
      And I should not see "Browse/edit groups"
#authorization.feature starts

  Scenario: Account Creation page (from Home page)
    Given I am on "Home"
     When I follow "Sign Up"
     Then I should be on "Registration" page
	  And I should see "Create your account"
	  And I should see "Find your friends"
	  And I should see "FreeFeed!"
	  And I should see "Sign up with one click:"
	  And I should see "Join FreeFeed + find your firends with one click via:"
	  And I should see "Or fill out the form below:"
	  And I should see "Have a Facebook account? Log in to prefill the form below with your profile information."
      And I should see "Name"
	  And I should see "Email Address"
      And I should see "FreeFeed Password"
      And I should see "Re-enter Password"
      And I should see "Register" button
	  And I should see "Make my feed public" checkbox
	  And "Make my feed public" checkbox is checked
	  And I should see "Terms of Service"
	  And I should see "Privacy Policy"
      And I should not see a footer
#reduced footer is displayed at this point
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see a list of my groups
      And I should not see "Browse/edit groups"
#registration.feature starts

  Scenario: Find Friends page (Registration step 2)
    Given I am on "registration" page
     When I fill all fields correctly
	  And press "Register" button
     Then I should be on "Find Friends" page
	  And I should see "Create your account"
	  And I should see "Find your friends"
	  And I should see "FreeFeed!"
	  And I should see "Popular FreeFeeders"
	  And I should see "The folks below are popular among other FreeFeeders, so you might find their feeds interesting as well."
	  #And I should see popular users
	  And I should see "Next: See your FreeFeed!" button
      And I should see a footer

  Scenario: Login error page
    Given I am on "Sign in" page
	 When I enter incorrect information
	  And press "Sign in" button
	 Then I should be on "Login error" page
	  And I should see logo
	  And I should see "Sign in to FreeFeed"
	  And I should see "Email or username"
	  And I should see "Password"
	  And I should see "Forgot your password?"
	  And I should see "Remember me on this computer"
	  And I should see "Sign in" button
	  And I should see "Created an account via Google, Facebook, or Twitter? Sign in with the buttons below:"
	  And I should see "Facebook" button
	  And I should see "Google" button
	  And I should see "Twitter" button
	  And I should see "Create an account"
	  And I should see "New to FreeFeed?"
	  And I should see footer
  
