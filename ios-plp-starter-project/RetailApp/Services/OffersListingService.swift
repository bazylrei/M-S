import Foundation

protocol OffersListingService {
  func getOffers(completion: @escaping(Result<OffersPayload, Error>) -> Void)
}

class OffersListingServiceImplementation: OffersListingService {
  private let api: API
  
  init(api: API = API()) {
    self.api = api
  }
  
  func getOffers(completion: @escaping (Result<OffersPayload, Error>) -> Void) {
    let resource = Resource<OffersPayload>(path: Path.offerForCustomerURLString(withID: "5"))
    api.load(resource, completion: completion)
  }
}
