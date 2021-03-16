import Foundation

struct ProductDetails: Codable {
  let id: String
  let name: String
  let imageKey: String
  let price: Price
  let information: [ProductInformation]
}
