import Foundation
@testable import RetailApp

class MockOffersFormatter: OffersFormatter {
  func format(offersPayload: OffersPayload) -> [Offer] {
    offersPayload.offers.map { Offer(id: $0.id , badge: Badge(name: $0.title, types: [], priority: 0))}
  }
}
