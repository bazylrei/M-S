import Foundation

protocol OffersListingProviding {
  func fetch(for userID: String, completion: (([Offer]) -> Void)?)
}

class OffersListingProvider: OffersListingProviding {
  let offersListingService: OffersListingService
  let imageService: ImageService
  let offersFormatter: OffersFormatter
  var offerBadges = [Offer]()
  
  init(offersListingService: OffersListingService = OffersListingServiceImplementation(),
       offersFormatter: OffersFormatter = OffersFormatterImplementation(),
       imageService: ImageService = ImageServiceImplementation()) {
    self.offersListingService = offersListingService
    self.imageService = imageService
    self.offersFormatter = offersFormatter
  }
  
  func fetch(for userID: String, completion: (([Offer]) -> Void)?) {
    offersListingService.getOffers { [weak self] offersPayload in
      guard let self = self else {
        return
      }
      do {
        let offersPayload = try offersPayload.unwrapped()
        let offerBadges = self.offersFormatter.format(offersPayload: offersPayload)
        offerBadges.forEach { badgeOffer in
          self.imageService.downloadBadge(name: badgeOffer.badge.name, completion: { result in
            do {
              badgeOffer.badge.image = try result.unwrapped()
            } catch {
              print("Failed to download badge image")
            }
          })
        }
        self.offerBadges = offerBadges
        completion?(offerBadges)
      } catch {
        print("failed to read loaded offers")
      }
    }
  }
}
