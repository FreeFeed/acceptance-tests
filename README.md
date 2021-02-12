# Freefeed Acceptance Tests

1. `yarn` to install Cypress (https://cypress.io).
1. `yarn cypress:run` to run the headless test suite.
1. `yarn cypress:open` to open Cypress app and run tests manually or write new ones. 

Note: by default the tests are running against your local [development server](https://github.com/FreeFeed/freefeed-server), so it should be installed and running when your run the test suite. You can change the target server by modifying `"baseUrl"` in `./cypress.json` config file (for example, by setting it to `"baseUrl": "https://candy.freefeed.net/"`), but signup tests won't pass because of captcha.

### Useful links

- https://docs.cypress.io/guides/getting-started/writing-your-first-test.html
- https://docs.cypress.io/api/api/table-of-contents.html
- https://docs.cypress.io/guides/references/configuration.html
- https://docs.cypress.io/guides/guides/continuous-integration.html
