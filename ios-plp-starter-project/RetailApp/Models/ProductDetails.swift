import Foundation

struct ProductDetails: Codable, ProductRequest {
  let id: String
  let name: String
  let imageKey: String
  let price: Price
  let offerIds: [String]
  let information: [ProductInformation]?
}
