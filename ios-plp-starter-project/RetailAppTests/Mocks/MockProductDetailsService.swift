import Foundation
@testable import RetailApp

class MockProductDetailsService: ProductDetailsService {
  private(set) var lastCompletion: ((Result<ProductDetails, Error>) -> Void)? = nil
  var callCount = 0
  var requestedIDs: [String] = []
  func getProduct(id: String, completion: @escaping (Result<ProductDetails, Error>) -> Void) {
    lastCompletion = completion
    callCount += 1
    requestedIDs.append(id)
  }
}
