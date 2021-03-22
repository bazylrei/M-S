import XCTest
@testable import RetailApp

class OffersListingProviderTests: XCTestCase {
  
  var offersProvider: OffersListingProvider!
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func testOffersProviderFetch() {
    offersProvider = OffersListingProvider(offersListingService: MockOffersListingService(), offersFormatter: MockOffersFormatter(), imageService: MockImageService())
    offersProvider.fetch(for: "0") { offers in
      XCTAssertEqual(offers.count, 5)
      
      XCTAssertEqual(offers[0].id, "1")
      XCTAssertEqual(offers[0].badge.name, "Get it while it lasts!")
      
      XCTAssertEqual(offers[1].id, "2")
      XCTAssertEqual(offers[1].badge.name, "Extra loyalty points!")
      
      XCTAssertEqual(offers[2].id, "3")
      XCTAssertEqual(offers[2].badge.name, "Priority Access!")
      
      XCTAssertEqual(offers[3].id, "4")
      XCTAssertEqual(offers[3].badge.name, "Discount available!")
      
      XCTAssertEqual(offers[4].id, "5")
      XCTAssertEqual(offers[4].badge.name, "Super sale!")
    }
  }
}
