import XCTest
@testable import RetailApp

class ProductListingViewModelTests: XCTestCase {
  var productListing: ProductListing!
  let mockProductListingService = MockProductListingService()
  let mockAppSetup = MockAppSetup()
  
  override func setUpWithError() throws {
    self.productListing = JSONLoader.productsListing
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_dataFetch() {
    _ = ProductListingViewModel(productListingService: mockProductListingService, appSetup: mockAppSetup)
    XCTAssertEqual(mockProductListingService.callCount, 1)
  }
  
  func test_fetch() {
    let viewModel = ProductListingViewModel(productListingService: mockProductListingService, appSetup: mockAppSetup)
    let actionExpectation = expectation(description: "updated")
    viewModel.productListing.bindNoFire(self) { productListing in
      XCTAssertEqual(productListing, self.productListing.products)
      XCTAssertEqual(viewModel.numberOfProducts, 3)
      actionExpectation.fulfill()
    }
    mockProductListingService.lastCompletion?(.value(productListing))
    wait(for: [actionExpectation], timeout: 0.1)
  }
  
  func test_product_andOffer() {
    
    mockAppSetup.offers.value = [
      Offer(id: "4", badge: Badge(name: "badge1", types: [], priority: 0)),
      Offer(id: "5", badge: Badge(name: "badge2", types: [], priority: 1))
    ]
    
    let viewModel = ProductListingViewModel(productListingService: mockProductListingService, appSetup: mockAppSetup)
    let actionExpectation = expectation(description: "updated")
    viewModel.productListing.bindNoFire(self) { productListing in
      let product = viewModel.product(at: 0)
      XCTAssertEqual(product.name, "Round Neck Jumper")
      let offer = viewModel.offerForProduct(at: 0)
      
      XCTAssertEqual(offer!.id, "4")
      actionExpectation.fulfill()
    }
    mockProductListingService.lastCompletion?(.value(productListing))
    wait(for: [actionExpectation], timeout: 0.1)
    
    
  }
}

extension ProductDetails: Equatable {
  public static func == (lhs: ProductDetails, rhs: ProductDetails) -> Bool {
    lhs.name == rhs.name &&
      lhs.imageKey == rhs.imageKey &&
      lhs.id == rhs.id
  }
  
  
}
