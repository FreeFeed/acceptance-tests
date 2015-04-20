Feature: Registration
  As a person who wants to connect with their friends, I want to be able
  to create freefeed account to be able to create my own home feed and
  subscribe to people.

  #doc: https://docs.google.com/document/d/12juTn1Szm-TRf-sYDzVXD_soJ4fgceH70bxGV7q6of4/edit#
  #see additional notes at the bottom

  Scenario: Step 1: User doesn't fill the fields
    Given I am on "Registration" page
	  And fields are empty
    When I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter your information"
#Above fields

  Scenario: Step 1: Empty Name error
    Given I am on "Registration" page
	When I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter your username"
#Above fields

  Scenario: Step 1: Empty email address error
    Given I am on "Registration" page
	When I fill "Name" with "_testunverified"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter your email address"
#Above fields

  Scenario: Step 1: Invalid email address error
    Given I am on Registration page
	When I fill "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified"
#Can we use standard regexp here? or do I need to fill all wrong email types?
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter correct email address"
#Above fields

  Scenario: Step 1: Empty password error
    Given I am on "Registration" page
	When I press "Register" button
	When I fill "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter correct password"
#Above fields
	  
  Scenario: Step 1: Invalid password error
    Given I am on "Registration" page
	When I fill "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "голубика"
	  And I fill "Re-enter Password" with "голубика"
#Again, do I need separate scenarios for every "incorrect password"?
#too short, too long, not latin, maybe wrong combo?
	  And I press "Register" button
	Then I am on "Registration" page
#Above fields
	  And I should see "Please enter password following these rules: between 8 and 25 characters, letters - only latin, digits and symbols optional."
#https://github.com/pepyatka/pepyatka-html/issues/198
	  
  Scenario: Step 1: Empty re-enter password error
    Given I am on "Registration" page
	When I fill "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please re-enter your password"
#Above fields
	  
  Scenario: Step 1: Password mismatch error
    Given I am on "Registration" page
	When I fill "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "pepyatka321"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "Please enter same password in both password fields"
#Above fields

  Scenario: Step 1: User already exists
    Given I am on "Registration" page
	  And there is user "_testuser" with password "ntcnbhjdfybt"
	When I fill in "Name" with "_testuser"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Registration" page
	  And I should see "This user already exists"
#Above fields

  Scenario: Step 1: Registered
    Given I am on "Registration" page
	  And all fields are filled correctly
	When I fill in "Name" with "_testunverified"
	  And I fill "Email Address" with "freefeed.net+unverified@example.com"
	  And I fill "FriendFeed Password" with "ntcnbhjdfybt"
	  And I fill "Re-enter Password" with "ntcnbhjdfybt"
	  And I press "Register" button
	Then I am on "Find Friends" page
#Find Friends behavior is unknown

  Scenario: Step 2: Go to Friend recommendations
    Given I am on "Find Friends" page
	When I press "Next: Friend recommendations" button
	Then I am on "Recommendations" page

  Scenario: Step 3: Go to FriendFeed
    Given I am on "Recommendations" page
	When I press "Next: See your FriendFeed!" button
	Then I am on "Home" page
	  And I am logged in

	
  #make my feed public (anyone can read it) checked by default
  #Create my account button
  #confirm email flow