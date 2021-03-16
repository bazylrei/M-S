import UIKit

protocol PriceFormatter {
  func formatPrice(_ price: Price) -> NSAttributedString
}

struct PriceFormatterImplementation: PriceFormatter {

  let discountedPriceColor: UIColor
  let priceColor: UIColor
  let numberFormatter = NumberFormatter()

  init(discountedPriceColor: UIColor = .red, priceColor: UIColor = .black) {
    self.discountedPriceColor = discountedPriceColor
    self.priceColor = priceColor
    numberFormatter.numberStyle = .currency
  }

  private func stringFromPrice(price: Int) -> String {
    let divisor = pow(10, numberFormatter.minimumFractionDigits)
    let decimalPrice = Decimal(integerLiteral: price) / divisor
    return numberFormatter.string(from: decimalPrice as NSDecimalNumber) ?? ""
  }

  private func formatCurrentPrice(_ currentPrice: Int, isDiscounted: Bool) -> NSAttributedString {
    let currentPriceString = stringFromPrice(price: currentPrice)
    let currentPriceColor = isDiscounted ? discountedPriceColor : priceColor
    return NSAttributedString(string: currentPriceString, attributes: [NSAttributedString.Key.foregroundColor: currentPriceColor])
  }

  private func formatOriginalPrice(_ originalPrice: Int?) -> NSAttributedString? {
    guard let originalPrice = originalPrice else {
      return nil
    }
    let originalPriceString = stringFromPrice(price: originalPrice)
    return NSAttributedString(string: originalPriceString, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor: priceColor])
  }

  func formatPrice(_ price: Price) -> NSAttributedString {
    numberFormatter.currencyCode = price.currencyCode
    let isDiscountedPrice = price.originalPrice != nil
    let priceString = NSMutableAttributedString(attributedString: formatCurrentPrice(price.currentPrice, isDiscounted: isDiscountedPrice))
    if let originalPrice = formatOriginalPrice(price.originalPrice) {
      priceString.append(NSAttributedString(string: " "))
      priceString.append(originalPrice)
    }
    return priceString
  }
}

