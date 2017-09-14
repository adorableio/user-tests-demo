describe('Hello world', function () {
  it('should have navigation on the homepage', function () {
    cy.visit('http://localhost:3000');

    cy.title().should('include', 'base-react-app')
    cy.contains('h2', 'Home')
    cy.contains('li', 'Home')
    cy.contains('li', 'Foo')

    cy.contains('button', 'Get Content')
      .click()

    cy.contains('.content', 'name: nauto')
    cy.contains('.content', 'description: awesome')
    cy.contains('.content', 'updated_at: 2017-09-13T23:11:23.912Z')
  });

  it('should navigate to the Foo page', function () {
    cy.contains('h2', 'Home')
    cy.contains('li a', 'Foo').click()

    cy.contains('h2', 'Foo')
  });

  it('should add foos', function () {
    cy.contains('li a', 'Foo').click()

    cy.contains('h2', 'Foo')

    cy.contains('button', 'Add Foo')
    .click()

    cy.contains('div div', 'foo')
  });
});
