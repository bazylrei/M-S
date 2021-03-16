import Foundation
@testable import RetailApp

struct ProductRequestStub: ProductRequest {
  let id: String
  let price: Price
  let name: String
}
