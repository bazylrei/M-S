import Foundation

class ProductListingViewModel {
  private let productListingService: ProductListingService
  let appSetup: AppSetupType
  var productListing = Observable<[ProductDetails]?>(nil)
  
  init(productListingService: ProductListingService = ProductListingServiceImplementation(),
       appSetup: AppSetupType) {
    self.productListingService = productListingService
    self.appSetup = appSetup
    getProducts()
  }
  
  var numberOfProducts: Int {
    productListing.value?.count ?? 0
  }
  
  func product(at index: Int) -> ProductDetails {
    guard let productDetails = productListing.value else {
      fatalError("ProductDetails failed to initiate")
    }
    return productDetails[index]
  }
  
  func offerForProduct(at index: Int) -> Offer? {
    let productDetails = product(at: index)
    let availableOffers = productDetails.offerIds?.compactMap { offerID in
      appSetup.offers.value?.first(where: { $0.id == offerID })
    }
    
    let topPriorityOffer = availableOffers?.min { a, b in a.badge.priority < b.badge.priority }
    return topPriorityOffer
  }
  
  private func getProducts() {
    productListingService.getProducts { [weak self] result in
      do {
        let result = try result.unwrapped()
        self?.productListing.value = result.products
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
