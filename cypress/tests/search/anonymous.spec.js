const randomUser = require('../../utils/random-user');

describe('Anonymous user can search', () => {
  it('Can find something from a public post', () => {
    // Prepare a public post with a comment
    const publicUser = randomUser();
    const postText = 'Public post';
    const commentText = 'Public comment';

    cy.register(publicUser).then((user) => {
      const authToken = user.authToken;

      cy.post(postText, [publicUser.username], authToken).then((post) => {
        const postId = post.posts.id;
        cy.comment(commentText, postId, authToken).then(() => {
          // Search for them
          cy.visit(`/${publicUser.username}`);

          cy.findByPlaceholderText(/Search request/i)
            .clear()
            .type(`in:${publicUser.username} "${postText}"`);
          cy.findByText(/Search/i, { selector: 'button' }).click();
          cy.findByRole('mark').should('have.text', postText);

          cy.findByPlaceholderText(/Search request/i)
            .clear()
            .type(`in:${publicUser.username} "${commentText}"`);
          cy.findByText(/Search/i, { selector: 'button' }).click();
          cy.findByRole('mark').should('have.text', commentText);
        });
      });
    });
  });
});
