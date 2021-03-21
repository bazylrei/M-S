import Foundation

class ProductListingViewModel {
  private let productListingService: ProductListingService
  let appSetup: AppSetup
  var productDetails = Observable<[ProductDetails]?>(nil)
  
  init(productListingService: ProductListingService = ProductListingServiceImplementation(),
       appSetup: AppSetup) {
    self.productListingService = productListingService
    self.appSetup = appSetup
    getProducts()
  }
  
  var numberOfSections: Int {
    1
  }
  
  var numberOfProducts: Int {
    productDetails.value?.count ?? 0
  }
  
  func product(at index: Int) -> ProductDetails {
    guard let productDetails = productDetails.value else {
      fatalError("ProductDetails failed to initiate")
    }
    return productDetails[index]
  }
  
  func badgeForProduct(at index: Int) -> Offer? {
    let productDetails = product(at: index)
    let availableOffers = productDetails.offerIds.compactMap { offerID in
      appSetup.offers.value?.first(where: { $0.id == offerID })
    }
    
    let topPriorityOffer = availableOffers.min { a, b in a.badge.priority < b.badge.priority }
    return topPriorityOffer
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
