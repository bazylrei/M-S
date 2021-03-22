import Foundation

protocol AppSetupType {
  var offers: Observable<[Offer]?> { get }
  func initiate(for user: String, completion: (() -> Void)?)
}

class AppSetup: AppSetupType {
  private let offersListingProvider: OffersListingProviding
  var offers = Observable<[Offer]?>(nil)
  
  init(offersListingProvider: OffersListingProviding = OffersListingProvider()) {
    self.offersListingProvider = offersListingProvider
  }
  
  func initiate(for user: String = "5", completion: (() -> Void)? = nil) {
    offersListingProvider.fetch(for: user) { [weak self] offers in
      self?.offers.value = offers
      completion?()
    }
  }
}
