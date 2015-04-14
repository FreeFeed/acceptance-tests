Feature: Page elements.
  As a user I want to be able to see all page elements where they should be.

  #Login error
  #Home feed
  #Direct messages
  #My subscriptions
  #Friends
  #Groups
  #Settings
  #Search, advanced search
  #Saved searches
  #Footer
  #tools
  #settings
  #email/im/desktop notifications
  #done Home not logged
  #done Login
  #done Registration

  Scenario: Home page, not logged in
    Given I am on home page
      And I am not logged in
     Then I should see "Create an account"
      And I should see "Already have an account?"
      And I should see "Username"
      And I should see "Password"
      And I should see footer
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see list of my groups
      And I should not see "Browse/edit groups"
  
  Scenario: Sign in leads to login page
    Given I am on home page
      And I am not logged in
     When I follow "Sign In"
     Then I should be on login page
      And I should see "Already have an account?"
      And I should see "Created an account via Google, Facebook, or Twitter? Sign in here"
      And I should see "Username"
      And I should see "Password"
      And I should see "Sign In" button
      And I should see footer
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see list of my groups
      And I should not see "Browse/edit groups"
#authorization.feature starts

  Scenario: Sign Up leads to account creation page
    Given I am on home page
      And I am not logged in
     When I follow "Sign Up"
     Then I should be on registration page
      And I should see "Username"
      And I should see "Password"
      And I should see "Confirm Password"
      And I should see "Enter display name"
      And I should see "Sign Up" button
      And I should see footer
      And I should not see "Home"
      And I should not see "Direct Messages"
      And I should not see "My discussions"
      And I should not see "Best of day"
      And I should not see "Browse/edit friends"
      And I should not see "Groups"
      And I should not see list of my groups
      And I should not see "Browse/edit groups"
  
