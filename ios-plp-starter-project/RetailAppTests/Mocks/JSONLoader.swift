import Foundation
@testable import RetailApp

class JSONLoader {
  static var productsListing: ProductListing {
    let resource = Resource<ProductListing>(path: "")
    let data = fetch(fileName: "Products")
    return try! resource.parse(data!).unwrapped()
  }
  
  static var firstProduct: ProductDetails {
    return productsListing.products[0]
  }
  
  static func offersPayload(for id: String) -> OffersPayload {
    let resource = Resource<OffersPayload>(path: "")
    let data = fetch(fileName: "OffersPayload\(id)")
    return try! resource.parse(data!).unwrapped()
  }
  
  static private func fetch(fileName: String) -> Data? {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
      print("failed to load json file")
      return nil
    }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      return data
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
