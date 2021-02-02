# Freefeed Acceptance Tests

## Run locally
1. `yarn` to install Cypress (https://cypress.io).
2. `yarn cypress:run` to run the headless test suite.
3. `yarn cypress:open` to open Cypress app and run tests manually or work on writing new ones. Change `baseUrl` in `cypress.json` if you want to work with your local dev server.

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

- https://docs.cypress.io/api/api/table-of-contents.html
- https://docs.cypress.io/guides/references/configuration.html
- https://docs.cypress.io/guides/guides/continuous-integration.html
