import Foundation
import XCTest
@testable import RetailApp

class AppSetupTests: XCTestCase {
  var offers: Offer!
  var appSetup: AppSetup!
  var mockOffersListingProvider: MockOffersListingProvider!
  
  override func setUp() {
    super.setUp()
    mockOffersListingProvider = MockOffersListingProvider()
    appSetup = AppSetup(offersListingProvider: mockOffersListingProvider)
  }
  
  override func tearDown() {
    mockOffersListingProvider = nil
    appSetup = nil
    offers = nil
    super.tearDown()
  }
  
  func testInitiation() {
    let offers = [
      Offer(id: "4", badge: Badge(name: "badge1", types: [], priority: 0)),
      Offer(id: "5", badge: Badge(name: "badge2", types: [], priority: 1))
    ]
    
    appSetup.initiate(for: "1") { [weak self] in
      XCTAssertEqual(self?.mockOffersListingProvider.offers, offers)
    }
  }
}

extension Offer: Equatable {
  public static func == (lhs: Offer, rhs: Offer) -> Bool {
    lhs.badge == rhs.badge &&
      lhs.id == rhs.id
  }
}
