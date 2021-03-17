// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })

import '@testing-library/cypress/add-commands';
import 'cypress-localstorage-commands';
import 'cypress-file-upload';

const backendUrl = Cypress.config('backendUrl');
const authTokenLocalStorageName = Cypress.config('authTokenLocalStorageName');

// Login as a user
Cypress.Commands.add('login', ({ username, password }) => {
  cy.request({
    method: 'POST',
    url: `${backendUrl}/v1/session`,
    body: {
      username,
      password,
    },
  }).then((response) => {
    const authToken = response.body.authToken;
    window.localStorage.setItem(authTokenLocalStorageName, authToken);
  });
});

// Create a new user and log in
Cypress.Commands.add('register', ({ username, password, email, screenName }) => {
  cy.request({
    method: 'POST',
    url: `${backendUrl}/v1/users`,
    body: {
      username,
      screenName,
      email,
      password,
    },
  }).then((response) => response.body);
});

// Change privacy of current user (must be already logged in)
Cypress.Commands.add('changeUserPrivacy', (userId, targetPrivacy, authToken) => {
  const isPrivate = targetPrivacy === 'private' ? '1' : '0';
  const isProtected = targetPrivacy === 'protected' ? '1' : '0';

  const body = {
    user: { isPrivate, isProtected },
  };

  cy.request({
    method: 'PUT',
    url: `${backendUrl}/v1/users/${userId}`,
    body,
    headers: {
      Authorization: `Bearer ${authToken}`,
    },
  }).then((response) => response.body);
});

// Write a simple post to user's own feed or some other feeds (must be already logged in)
Cypress.Commands.add('post', (postText, feeds, authToken) => {
  const body = {
    post: { body: postText, attachments: [] },
    meta: { feeds, commentsDisabled: false },
  };

  cy.request({
    method: 'POST',
    url: `${backendUrl}/v1/posts`,
    body,
    headers: {
      Authorization: `Bearer ${authToken}`,
    },
  }).then((response) => response.body);
});

// Write a comment to a post (must be already logged in)
Cypress.Commands.add('comment', (commentText, postId, authToken) => {
  const body = {
    comment: { body: commentText, postId },
  };

  cy.request({
    method: 'POST',
    url: `${backendUrl}/v1/comments`,
    body,
    headers: {
      Authorization: `Bearer ${authToken}`,
    },
  }).then((response) => response.body);
});
