import Foundation
@testable import RetailApp

class MockOffersListingService: OffersListingService {
  func getOffers(completion: @escaping (Result<OffersPayload, Error>) -> Void) {
    let offersPayload = JSONLoader.offersPayload(for: "5")
    completion(.value(offersPayload))
  }
}
