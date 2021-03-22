import Foundation
@testable import RetailApp

class MockProductListingService: ProductListingService {
  private(set) var lastCompletion: ((Result<ProductListing, Error>) -> Void)? = nil
  var callCount = 0
  
  func getProducts(completion: @escaping (Result<ProductListing, Error>) -> Void) {
    lastCompletion = completion
    callCount += 1
  }
}
