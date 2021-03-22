import XCTest
@testable import RetailApp

class OffersFormatterTests: XCTestCase {
  var offersPayload: OffersPayload!
  let offersFormatter = OffersFormatterImplementation()
  
  func testOffer() {
    self.offersPayload = JSONLoader.offersPayload(for: "5")
    
    let offers = offersFormatter.format(offersPayload: offersPayload)
    let badge1 = Badge(name: "gonesoon", types: ["REDUCED"], priority: 0)
    let badge2 = Badge(name: "loyalty", types: ["SLOTTED", "BONUS"], priority: 2)
    let badge3 = Badge(name: "sale", types: ["PRIORITY_ACCESS"], priority: 1)
    
    XCTAssertEqual(offers.count, 5)
    XCTAssertEqual(offers[0].id, "1")
    XCTAssertEqual(offers[0].badge, badge1)
    
    XCTAssertEqual(offers[1].id, "2")
    XCTAssertEqual(offers[1].badge, badge2)
    
    XCTAssertEqual(offers[2].id, "3")
    XCTAssertEqual(offers[2].badge, badge3)
    
    XCTAssertEqual(offers[3].id, "4")
    XCTAssertEqual(offers[3].badge, badge2)
    
    XCTAssertEqual(offers[4].id, "5")
    XCTAssertEqual(offers[4].badge, badge2)
  }
  
  func test_noAvailableOffers() {
    self.offersPayload = JSONLoader.offersPayload(for: "3")
    let offers = offersFormatter.format(offersPayload: offersPayload)
    
    XCTAssertEqual(offers.count, 0)
  }
}

extension Badge: Equatable {
  public static func == (lhs: Badge, rhs: Badge) -> Bool {
    lhs.name == rhs.name &&
      lhs.priority == rhs.priority &&
      lhs.types == rhs.types
  }
  
  
}
