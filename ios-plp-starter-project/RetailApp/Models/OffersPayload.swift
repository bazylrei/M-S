import Foundation

struct OffersPayload: Codable {
  let offers: [OfferModel]
  let availableBadges: String
}
