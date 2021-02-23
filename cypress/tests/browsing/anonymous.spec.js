const randomUser = require('../../utils/random-user');

describe('Anonymous user can browse', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('Visits main page and sees a weclome page with a signup link', () => {
    cy.get('header')
      .findByText(/Sign in/i, { selector: 'a' })
      .should('exist');
    cy.get('[role=main]')
      .findByText(/Welcome to FreeFeed!/i)
      .should('exist');
    cy.get('[role=main]')
      .findByText(/Sign up/i, { selector: 'a' })
      .should('exist');
  });

  it('Dismisses privacy popup and gets privacy cookie', () => {
    cy.visit('/');

    cy.clearCookies();
    cy.findByText(/This site uses cookies/i).should('exist');
    cy.findByText(/Privacy policy/i, { selector: 'a' }).should('exist');
    cy.findByText(/Accept/i, { selector: 'button' }).should('exist');
    cy.findByText(/Accept/i, { selector: 'button' }).click();
    cy.findByText(/This site uses cookies/i).should('not.exist');
    cy.getCookie('privacy').should('have.property', 'value', 'true');
  });

  it('Can access signin page', () => {
    cy.get('header')
      .findByText(/Sign in/i, { selector: 'a' })
      .click();

    cy.get('[role=main]')
      .findByText(/Sign in/i, { selector: 'h2' })
      .should('exist');
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Username or email address/i)
      .should('exist');
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Password/i)
      .should('exist');

    cy.get('[role=main]')
      .find('form')
      .findByText(/Sign in/i, { selector: 'button' })
      .should('exist');
  });

  it('Can access signup page', () => {
    cy.get('[role=main]')
      .findByText(/Sign up/i, { selector: 'a' })
      .click();

    cy.get('[role=main]')
      .findByText(/Sign up/i, { selector: 'h2' })
      .should('exist');
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Username/i)
      .should('exist');
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Screen Name/i)
      .should('exist');
    cy.get('[role=main]').find('form').findByLabelText(/Email/i).should('exist');
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Password/i)
      .should('exist');

    cy.get('[role=main]')
      .find('form')
      .findByText(/Create account/i, { selector: 'button' })
      .should('exist');
  });

  it('Can access public posts', () => {
    // Prepare a public post
    const publicUser = randomUser();

    cy.register(publicUser).then((user) => {
      const authToken = user.authToken;

      cy.post('Public post', [publicUser.username], authToken).then(() => {
        // Check if we can read it
        cy.visit(`/${publicUser.username}`);

        cy.findByRole('feed').should('exist');
        cy.findAllByLabelText('Post body').should('have.length', 1);
        cy.findByRole('feed')
          .findByText(/Comment/i, { selector: 'a' })
          .should('not.exist');
      });
    });
  });

  it('Cannot access protected posts', () => {
    // Prepare a protected post
    const protectedUser = randomUser();

    cy.register(protectedUser).then((user) => {
      const authToken = user.authToken;
      const userId = user.users.id;

      cy.post('Protected post', [protectedUser.username], authToken).then(() => {
        cy.changeUserPrivacy(userId, 'protected', authToken).then(() => {
          // Check if we can read it
          cy.visit(`/${protectedUser.username}`);

          cy.findByRole('feed').should('not.exist');
          cy.findAllByLabelText('Post body').should('have.length', 0);
        });
      });
    });
  });
});
