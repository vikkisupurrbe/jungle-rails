describe("Cart Functionality from Home Page", () => {
  it("should visit root", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });

  it("adds a product to the cart when 'Add to Cart' is clicked", () => {
    cy.visit("/");
  
    // Confirm initial cart count is 0
    cy.get(".navbar").contains("My Cart (0)");
  
    // Find the first product that is *not sold out* and click "Add"
    cy.get(".products article")
      .contains("Add")
      .click({ force: true });
  
    // Confirm the cart count increased to 1
    cy.get(".navbar").contains("My Cart (1)");
  });  
});