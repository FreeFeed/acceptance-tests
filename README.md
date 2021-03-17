# Freefeed Acceptance Tests

## Run locally

-  `yarn` to install Cypress (https://cypress.io).

-  `yarn cypress:run` to run the headless test suite.

-  `yarn cypress:open` to open Cypress app and run tests manually or write new ones.

Note: by default the tests are running against your local [development server](https://github.com/FreeFeed/freefeed-server), so it should be installed and running when your run the test suite. You can change the target server by modifying `"baseUrl"`, `"backendUrl"` and `"authTokenLocalStorageName"` in `./cypress.json` config file.

## Run in docker


```bash

docker build -t tests:local .

docker run tests:local run

```
Mount subfolder from current folder for screenshots

```bash

docker run -v ${PWD}/screenshots:/app/cypress/screenshots tests:local run

```

### Useful links

- https://docs.cypress.io/guides/getting-started/writing-your-first-test.html
- https://docs.cypress.io/api/api/table-of-contents.html
- https://docs.cypress.io/guides/references/configuration.html
- https://docs.cypress.io/guides/guides/continuous-integration.html
- https://docs.cypress.io/guides/references/best-practices.html
