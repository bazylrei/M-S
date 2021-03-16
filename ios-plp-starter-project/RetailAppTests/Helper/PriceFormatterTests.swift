import XCTest
@testable import RetailApp

class PriceFormatterTests: XCTestCase {

  func test_formatPrice_whenNoDiscount_hasCorrectPriceValue() {
    let priceFormatterSUT = PriceFormatterImplementation()
    let price = Price(currentPrice: 1000, originalPrice: nil, currencyCode: "GBP")
    let priceString = priceFormatterSUT.formatPrice(price).string
    XCTAssertEqual(priceString, "£10.00")
  }

  func test_formatPrice_whenNoDiscountWithDecimalPrice_hasCorrectPriceValue() {
    let priceFormatterSUT = PriceFormatterImplementation()
    let price = Price(currentPrice: 12121, originalPrice: nil, currencyCode: "GBP")
    let priceString = priceFormatterSUT.formatPrice(price).string
    XCTAssertEqual(priceString, "£121.21")
  }

  func test_formatPrice_whenDiscounted_hasCorrectPriceValue() {
    let priceFormatterSUT = PriceFormatterImplementation()
    let price = Price(currentPrice: 1050, originalPrice: 1105, currencyCode: "GBP")
    let priceString = priceFormatterSUT.formatPrice(price).string
    XCTAssertEqual(priceString, "£10.50 £11.05")
  }

}
