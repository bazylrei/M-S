import Foundation

struct Price: Codable {
  let currentPrice: Int
  let originalPrice: Int?
  let currencyCode: String
}

