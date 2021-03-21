import Foundation

protocol OffersFormatter {
  func format(offersPayload: OffersPayload) -> [Offer]
}

class OffersFormatterImplementation: OffersFormatter {
  func format(offersPayload: OffersPayload) -> [Offer]  {
    let badges = parse(availableBadges: offersPayload.availableBadges)
    return setBadgesFor(offers: offersPayload.offers, badges: badges)
  }
  
  private func parse(availableBadges: String) -> [Badge] {
    let badgeStrings = availableBadges.components(separatedBy: "||")
    var badges = [Badge]()
    for (index, badgeString) in badgeStrings.enumerated() {
      if let badge = parse(badgeString: badgeString, at: index) {
        badges.append(badge)
      }
    }
    return badges
  }
  
  private func parse(badgeString: String, at index: Int) -> Badge? {
    let parsedBadgeData = badgeString.split(separator: ":")
    guard parsedBadgeData.count == 2 else {
      print("failed to parse badge")
      return nil
    }
    let badgeName = String(parsedBadgeData[0])
    let badgeTypes = parsedBadgeData[1].split(separator: ",").map { String($0) }
    let badge = Badge(name: badgeName, types: badgeTypes, priority: index)
    return badge
  }
  
  private func setBadgesFor(offers: [OfferModel], badges: [Badge]) -> [Offer] {
    offers.compactMap { offer in
      guard let badge = badges.find(for: offer.type) else {
        return nil
      }
      return Offer(id: offer.id, badge: badge)
    }
  }
}

extension Array where Element == Badge {
  func find(for offerType: String) -> Badge? {
    self.first(where: { $0.types.contains(offerType) })
  }
}
