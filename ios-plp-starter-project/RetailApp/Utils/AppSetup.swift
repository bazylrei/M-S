import Foundation

protocol AppSetupType {
  var offers: Observable<[Offer]?> { get }
  func initiate()
}

class AppSetup: AppSetupType {
  private let offersListingProvider: OffersListingProviding
  var offers = Observable<[Offer]?>(nil)
  
  init(offersListingProvider: OffersListingProviding = OffersListingProvider()) {
    self.offersListingProvider = offersListingProvider
  }
  
  func initiate() {
    offersListingProvider.fetch(for: "5") { [weak self] offers in
      self?.offers.value = offers
      print(offers)
    }
  }
}
