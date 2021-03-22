import Foundation
@testable import RetailApp

class MockOffersListingProvider: OffersListingProviding {
  var offers = [Offer]()
  func fetch(for userID: String, completion: (([Offer]) -> Void)?) {
    let offers = [
      Offer(id: "4", badge: Badge(name: "badge1", types: [], priority: 0)),
      Offer(id: "5", badge: Badge(name: "badge2", types: [], priority: 1))
    ]
    self.offers = offers
    completion?(offers)
  }
}
