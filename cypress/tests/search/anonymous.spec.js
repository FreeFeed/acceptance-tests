describe('Anonymous user can search', () => {
  it('Can find something from a post', () => {
    cy.visit('/welcome');

    cy.findAllByLabelText(/Post body/i)
      .eq(1)
      .find('.Linkify')
      .invoke('text')
      .then((postText) => {
        cy.findByPlaceholderText(/Search request/i).type(postText);
        cy.findByText(/Search/i, { selector: 'button' }).click();
        cy.findByRole('mark').should('have.text', postText);
      });
  });

  it('Can find something from a comment', () => {
    cy.visit('/welcome');

    cy.findAllByRole('comment')
      .eq(1)
      .find('.Linkify')
      .invoke('text')
      .then((commentText) => {
        cy.findByPlaceholderText(/Search request/i).type(commentText);
        cy.findByText(/Search/i, { selector: 'button' }).click();
        cy.findByRole('mark').should('have.text', commentText);
      });
  });
});
