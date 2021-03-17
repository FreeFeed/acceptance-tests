const randomUser = require('../../utils/random-user');
const drone = randomUser();

describe('Sign up and delete user', () => {
  it('Can sign up', () => {
    cy.visit('/signup');

    cy.get('header')
      .findByText(/Sign in/i, { selector: 'a' })
      .should('exist');

    // This will not work if there is a captcha
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Username/i)
      .type(drone.username);
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Screen Name/i)
      .type(drone.screenName);
    cy.get('[role=main]').find('form').findByLabelText(/Email/i).type(drone.email);
    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/Password/i)
      .type(drone.password);
    cy.get('[role=main]')
      .find('form')
      .findByText(/Create account/i, { selector: 'button' })
      .click();

    cy.findByRole('alert').should('not.exist');

    cy.get('header')
      .findByText(/Sign in/i, { selector: 'a' })
      .should('not.exist');

    cy.get('[role=complementary]').find('[role=region]').findByText(drone.screenName).should('exist');

    cy.saveLocalStorage();
  });

  it('Can update its description and userpic', () => {
    cy.restoreLocalStorage();

    cy.visit('/');

    cy.get('[role=complementary]')
      .find('[role=region]')
      .findByText(/Settings/i)
      .click();

    cy.get('[role=main]')
      .findByText(/Settings/i)
      .should('exist');

    cy.get('[role=main]')
      .findByAltText(/Profile picture/i)
      .invoke('attr', 'src')
      .then((oldUserpicSrc) => {
        cy.get('#userpic-input').attachFile('userpic.jpg');
        cy.get('[role=main]')
          .findByText(/Updated!/i)
          .should('exist');
        cy.wait(100);
        cy.get('[role=main]')
          .findByAltText(/Profile picture/i)
          .invoke('attr', 'src')
          .then((newUserpicSrc) => {
            expect(oldUserpicSrc).not.to.eq(newUserpicSrc);
          });
      });

    cy.get('[role=main]')
      .find('form')
      .findByLabelText(/About you/i)
      .type(drone.description);

    cy.get('[role=main]')
      .findByText(/Update profile/i, { selector: 'button' })
      .click();

    cy.findByText(/Profile updated/i).should('exist');

    cy.visit(`/${drone.username}`);

    cy.get('[role=main]')
      .findByAltText(`Profile picture of ${drone.username}`)
      .closest('[role=region]')
      .findByText(drone.description)
      .should('exist');
  });

  it('Can write a post', () => {
    cy.restoreLocalStorage();

    cy.visit('/');

    const postText = `My designation is ${drone.screenName}.`;

    cy.get('[role=main]')
      .findByLabelText(/Write a post/i)
      .type(postText);

    cy.get('[role=main]').find('[role=form]').findByText(/Post/i, { selector: 'button' }).click();

    cy.findAllByText(postText).should('have.length', 1);
  });

  it('Can delete itself', () => {
    cy.restoreLocalStorage();

    cy.visit('/settings');

    cy.get('[role=main]').findByText(/here/i, { selector: 'a' }).click();

    cy.get('[role=main]').findByLabelText(`Enter @${drone.username}’s password to proceed:`).type(drone.password);
    cy.get('[role=main]')
      .findByText(/Delete my account/i)
      .click();

    cy.get('header')
      .findByText(/Sign in/i, { selector: 'a' })
      .should('exist');
  });
});
