import Foundation
@testable import RetailApp

class MockAppSetup: AppSetupType {
  var offers = Observable<[Offer]?>([])

  func initiate(for user: String, completion: (() -> Void)?) {
    completion?()
  }
}
