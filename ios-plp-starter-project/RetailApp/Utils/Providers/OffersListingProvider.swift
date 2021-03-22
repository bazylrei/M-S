import Foundation

protocol OffersListingProviding {
  func fetch(for userID: String, completion: (([Offer]) -> Void)?)
}

class OffersListingProvider: OffersListingProviding {
  let offersListingService: OffersListingService
  let offersFormatter: OffersFormatter
  var offers = [Offer]()
  
  init(offersListingService: OffersListingService = OffersListingServiceImplementation(),
       offersFormatter: OffersFormatter = OffersFormatterImplementation()) {
    self.offersListingService = offersListingService
    self.offersFormatter = offersFormatter
  }
  
  func fetch(for userID: String, completion: (([Offer]) -> Void)?) {
    offersListingService.getOffers { [weak self] offersPayload in
      guard let self = self else {
        return
      }
      do {
        let offersPayload = try offersPayload.unwrapped()
        let offers = self.offersFormatter.format(offersPayload: offersPayload)
        self.offers = offers
        completion?(offers)
      } catch {
        print("failed to read loaded offers")
      }
    }
  }
}
