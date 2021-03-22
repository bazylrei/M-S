import Foundation

struct Path {
  private static let base = "http://interview-tech-testing.herokuapp.com"
  private static let products = "api/products"
  private static let product = "api/product/"
  private static let user = "api/user"
  private static let offers = "offers"

  static var baseURL = URL(string: base)!
  static var productsURLString = products
  
  static func offerForCustomerURLString(withID id: String) -> String {
    "\(user)/\(id)/\(offers)"
  }
}
