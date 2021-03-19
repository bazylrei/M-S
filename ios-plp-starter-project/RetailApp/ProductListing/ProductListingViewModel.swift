import Foundation

class ProductListingViewModel {
  private let productListingService: ProductListingService
  var productDetails = Observable<[ProductDetails]>([])
  
  init(productListingService: ProductListingService = ProductListingServiceImplementation()) {
    self.productListingService = productListingService
    getProducts()
  }
  
  var numberOfSections: Int {
    1
  }
  
  var numberOfProducts: Int {
    productDetails.value.count
  }
  
  func product(at index: Int) -> ProductDetails {
    productDetails.value[index]
  }
  
  private func getProducts() {
    productListingService.getProducts { [weak self] result in
      do {
        let result = try result.unwrapped()
        self?.productDetails.value = result.products
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
