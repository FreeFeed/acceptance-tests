describe('Anonymous user can browse', () => {
  it('Visits main page and sees a weclome page with a signup link', () => {
    cy.visit('/');

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

  it('Sees a signin form', () => {
    cy.visit('/');

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

  it('Sees a signup form', () => {
    cy.visit('/');

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

  it('Visits @support and sees posts on first two pages', () => {
    cy.visit('/support');

    cy.findByRole('alert').should('not.exist');

    cy.findByAltText(/Profile picture of support/i)
      .closest('[role=region]')
      .findByText('FreeFeed Support')
      .should('exist');

    cy.findByRole('feed').should('exist');
    cy.findAllByLabelText(/Public post (.+) to support/i).should('have.length', 30);
    cy.findByText(/Comment/i, { selector: 'a' }).should('not.exist');

    cy.findByText(/Older items/i, { selector: 'a' }).click();
    cy.findAllByLabelText(/Public post (.+) to support/i).should('have.length', 30);
  });
});
