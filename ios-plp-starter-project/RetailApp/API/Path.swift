import Foundation

struct Path {
  private static let base = "http://interview-tech-testing.herokuapp.com/api/"
  private static let products = "products"
  private static let product = "product/"
  private static let user = "api/user/"
  private static let offers = "offers"
  
  static var productsURLString: String {
    "\(base)\(products)"
  }
}
