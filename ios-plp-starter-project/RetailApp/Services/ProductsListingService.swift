import Foundation

protocol ProductListingService {
  func getProducts(completion: @escaping(Result<[ProductDetails], Error>) -> Void)
}

class ProductListingServiceImplementation: ProductListingService {
  private let api: API
  
  init(api: API) {
    self.api = api
  }
  
  func getProducts(completion: @escaping (Result<[ProductDetails], Error>) -> Void) {
    let resource = Resource<[ProductDetails]>(path: Path.productsURLString)
    api.load(resource, completion: completion)
  }
  
  
}
