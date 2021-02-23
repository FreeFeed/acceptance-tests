const randomUser = require('../../utils/random-user');

describe('Users can like comments', () => {
  it('Can like public comments in public posts', () => {
    // 1. user A creates a post with a comment
    // 2. user B likes this comment
    // 3. user B sees +1 comment like
    // 4. user A cannot like their own comment
    // 5. user A can see user B in clikes-popup
    // 6. user B can unclike

    const userA = randomUser();
    const userB = randomUser();

    cy.register(userA).then((userAData) => {
      const authTokenA = userAData.authToken;

      cy.register(userB).then((userBData) => {
        const authTokenB = userBData.authToken;

        cy.post('Public post with comments to be liked', [userA.username], authTokenA).then((post) => {
          const postId = post.posts.id;

          cy.comment('Please like me I am awesome', postId, authTokenA).then(() => {
            cy.login(userB).then(() => {
              cy.visit(`/${userA.username}/${postId}`);
              cy.findByRole('article').should('exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('Like this comment').click();
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('1 comment like').should('exist');
            });

            cy.login(userA).then(() => {
              cy.visit(`/${userA.username}/${postId}`);
              cy.findByRole('article').should('exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('1 comment like').should('exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('Like this comment').click();
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('1 comment like').should('exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('1 comment like').click();
              //here be check for popup later
            });

            cy.login(userB).then(() => {
              cy.visit(`/${userA.username}/${postId}`);
              cy.findByRole('article').should('exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('Like this comment').click();
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('1 comment like').should('not.exist');
              cy.get('[role=main]').findAllByRole('comment').eq(0).findByLabelText('Like this comment').should('exist');
            });

          });
        });
      });
    });
  });
});
