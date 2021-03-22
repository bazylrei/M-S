import Foundation
@testable import RetailApp

class MockPriceFormatter: PriceFormatter {
  func formatPrice(_ price: Price) -> NSAttributedString {
    NSAttributedString(string: "\(price.currentPrice) \(price.currencyCode)")
  }
}
