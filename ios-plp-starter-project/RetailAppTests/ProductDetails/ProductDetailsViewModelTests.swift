import XCTest
@testable import RetailApp

class ProductDetailsViewModelTests: XCTestCase {

  let productRequest = ProductRequestStub(id: "1", price: Price(currentPrice: 1, originalPrice: nil, currencyCode: ""), name: "")
  let productDetails = ProductDetails(id: "1", name: "name", imageKey: "imageKey", price: Price(currentPrice: 1000, originalPrice: nil, currencyCode: "GBP"), information: [ProductInformation(sectionTitle: "title", sectionText: "section")])

  func test_init_startsFetchingProductDetails() {
    let mockProductDetailsService = MockProductDetailsService()
    _ = ProductDetailsViewModel(productRequest: ProductRequestStub(id: "1", price: Price(currentPrice: 1, originalPrice: nil, currencyCode: ""), name: ""), listingImage: nil, productDetailsService: mockProductDetailsService, imageService: MockImageService())
    XCTAssertEqual(mockProductDetailsService.callCount, 1)
    XCTAssertEqual(mockProductDetailsService.requestedIDs.first, "1")
  }

  func test_nameIsUpdated_whenProductIsSuccessfullyFetched() {
    let mockProductDetailsService = MockProductDetailsService()

    let productDetailsViewModelSUT = ProductDetailsViewModel(productRequest: productRequest, listingImage: nil, productDetailsService: mockProductDetailsService, imageService: MockImageService())

    let actionExpectation = expectation(description: "updated")
    productDetailsViewModelSUT.name.bindNoFire(self) { name in
      XCTAssertEqual(name, self.productDetails.name)
      actionExpectation.fulfill()
    }

    mockProductDetailsService.lastCompletion?(.value(productDetails))
    wait(for: [actionExpectation], timeout: 0.1)
  }

  func test_priceIsUpdated_whenProductIsSuccessfullyFetched() {
    let mockProductDetailsService = MockProductDetailsService()

    let productDetailsViewModelSUT = ProductDetailsViewModel(productRequest: productRequest, listingImage: nil, productDetailsService: mockProductDetailsService, imageService: MockImageService())

    let actionExpectation = expectation(description: "updated")
    productDetailsViewModelSUT.price.bindNoFire(self) { price in
      XCTAssertEqual(price.string, "£10.00")
      actionExpectation.fulfill()
    }

    mockProductDetailsService.lastCompletion?(.value(productDetails))
    wait(for: [actionExpectation], timeout: 0.1)
  }

  func test_productInformationIsUpdated_whenProductIsSuccessfullyFetched() {
    let mockProductDetailsService = MockProductDetailsService()

    let productDetailsViewModelSUT = ProductDetailsViewModel(productRequest: productRequest, listingImage: nil, productDetailsService: mockProductDetailsService, imageService: MockImageService())

    let actionExpectation = expectation(description: "updated")
    productDetailsViewModelSUT.information.bindNoFire(self) { information in
      XCTAssertEqual(information, "title\nsection")
      actionExpectation.fulfill()
    }

    mockProductDetailsService.lastCompletion?(.value(productDetails))
    wait(for: [actionExpectation], timeout: 0.1)
  }

  func test_whenProductIsFetched_imageDownloadIsRequested() {
    let mockProductDetailsService = MockProductDetailsService()
    let mockImageService = MockImageService()
    let productDetailsViewModelSUT = ProductDetailsViewModel(productRequest: productRequest, listingImage: nil, productDetailsService: mockProductDetailsService, imageService: mockImageService)
    _ = productDetailsViewModelSUT.image // Need to hold a reference to the above object, this silences the warning for not using it
    let actionExpectation = expectation(description: "called")
    mockImageService.onDownloadCalled = {
      actionExpectation.fulfill()
      XCTAssertEqual(mockImageService.callCount, 1)
      XCTAssertEqual(mockImageService.requestedKeys.first, "imageKey")
    }
    mockProductDetailsService.lastCompletion?(.value(productDetails))
    wait(for: [actionExpectation], timeout: 0.1)
  }

  func test_imageIsUpdated_whenImageDownloadIsSuccessful() {
    let mockProductDetailsService = MockProductDetailsService()
    let mockImageService = MockImageService()
    let productDetailsViewModelSUT = ProductDetailsViewModel(productRequest: productRequest, listingImage: nil, productDetailsService: mockProductDetailsService, imageService: mockImageService)

    mockProductDetailsService.lastCompletion?(.value(productDetails))

    let actionExpectation = expectation(description: "updated")
    productDetailsViewModelSUT.image.bindNoFire(self) { image in
      actionExpectation.fulfill()
    }
    mockImageService.lastCompletion?(.value(UIImage()))
    wait(for: [actionExpectation], timeout: 0.1)
  }
}
