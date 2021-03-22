import XCTest
@testable import RetailApp

class ProductListingCellViewModelTests: XCTestCase {
  var mockImageService: MockImageService!
  var productListCellViewModel: ProductListingCellViewModel!
  var productDetails: ProductDetails!
  var offer: Offer!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockImageService = MockImageService()
    productListCellViewModel = ProductListingCellViewModel(priceFormatter: MockPriceFormatter(), imageService: mockImageService)
    productDetails = JSONLoader.firstProduct
    offer = Offer(id: "1", badge: Badge(name: "badge1", types: [], priority: 1))
  }
  
  override func tearDownWithError() throws {
    mockImageService = nil
    productListCellViewModel = nil
    productDetails = nil
    offer = nil
    try super.tearDownWithError()
  }
  
  func testUpdateProductDetails() {
    let nameExpectation = expectation(description: "updatedName")
    let priceExpectation = expectation(description: "updatedPrice")
    let imageExpectation = expectation(description: "updateImage")
    productListCellViewModel.name.bindNoFire(self) { name in
      XCTAssertEqual(name, "Round Neck Jumper")
      nameExpectation.fulfill()
    }
    
    productListCellViewModel.price.bindNoFire(self) { price in
      XCTAssertEqual(price.string, "1250 GBP")
      priceExpectation.fulfill()
    }
    
    productListCellViewModel.image.bindNoFire(self) { image in
      XCTAssertEqual(image, #imageLiteral(resourceName: "Placeholder"))
      imageExpectation.fulfill()
    }
    
    productListCellViewModel.productDetails = self.productDetails
    mockImageService.lastCompletion?(.value(#imageLiteral(resourceName: "Placeholder")))
    wait(for: [nameExpectation], timeout: 0.1)
    wait(for: [priceExpectation], timeout: 0.1)
    wait(for: [imageExpectation], timeout: 0.1)
  }
  
  func testUpdateOffer() {
    let badgeExpectation = expectation(description: "badge")
    productListCellViewModel.offerImage.bindNoFire(self) { image in
      XCTAssertEqual(image, #imageLiteral(resourceName: "Placeholder"))
      badgeExpectation.fulfill()
    }
    productListCellViewModel.offer = offer
    mockImageService.lastCompletion?(.value(#imageLiteral(resourceName: "Placeholder")))
    wait(for: [badgeExpectation], timeout: 0.1)
  }
}
