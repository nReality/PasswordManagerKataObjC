# PasswordManagerKataObjC

This is an exersize in making a change to a production-like "Big ball of mud" by 
"making the change safe, then making the change easy, then making the easy change"

1. Create a Golden Master WITHOUT CHANGING ANY CODE (make it safe)
2. Make the requested change by:
  a. Dependency breaking: safely breaking out the aspect we are interested in from the ball of mud (make it safe)
  b. Get under test: write unit tests to capture the behaviour of that aspect (make it safe)
  c. Refactor to make clear: refactor so that the intent of that aspect is clear (make it easy)
  d. Add a failing test for the new behaviour (make it easy)
  e. Add the change (easy change)
  
Your product owner hands you the following prioritised backlog:
  1. Report status in a label instead of an alert
  2. We need stricter password criteria: mix of upper and lowercaseand common ones not allowed ("password","qwerty")
  3. We need stronger hashing algo for new users
  4. Store data in keychain, not user preferences
  5. Allow multi language support
  6. Forgot password: Can we add ability to get a hint
