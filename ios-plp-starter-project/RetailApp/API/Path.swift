import Foundation

struct Path {
  private static let base = "http://interview-tech-testing.herokuapp.com"
  private static let products = "api/products"
  private static let product = "api/product"
  private static let user = "api/user"
  private static let offers = "offers"
  private static let image = "image"

  static var baseURL = URL(string: base)!
  static var productsURLString = products
  
  static func productURLString(for id: String) -> String{
    "\(product)/\(id)"
  }
  
  static func offerForCustomerURLString(withID id: String) -> String {
    "\(user)/\(id)/\(offers)"
  }
  
  static func imageURLString(with name: String) -> String {
    "\(image)/\(name).jpg"
  }
}
