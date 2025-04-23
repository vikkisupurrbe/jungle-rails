describe("Product Details from Home Page", () => {
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

  it("should navigate to product detail page when a product is clicked", () => {
    cy.visit("/");
  
    // Click the first product's link
    cy.get(".products article").first().find("a").click();
  
    // Confirm we are on the product detail page by checking for expected content
    cy.get(".products-show").should("exist"); // Section for product detail
    cy.get(".product-detail h1").should("be.visible"); // Product name
  });
});