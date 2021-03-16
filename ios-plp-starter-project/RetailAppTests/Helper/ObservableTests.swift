import XCTest
@testable import RetailApp

class ObservableTests: XCTestCase {

  func test_init_setsInitialValue() {
    let observableSUT = Observable("initial")
    XCTAssertEqual(observableSUT.value, "initial")
  }

  func test_setValue_updatesValue() {
    let observableSUT = Observable("initial")
    observableSUT.value = "new"
    XCTAssertEqual(observableSUT.value, "new")
  }

  func test_setValue_callsActionOnObserver() {
    let observableSUT = Observable("initial")
    let actionExpectation = expectation(description: "action")
    observableSUT.bindNoFire(self) { value in
      actionExpectation.fulfill()
      XCTAssertEqual(value, "new")
    }
    observableSUT.value = "new"
    wait(for: [actionExpectation], timeout: 0.1)
  }

  func test_setValue_callsActionOnMultipleObservers() {
    let observableSUT = Observable("initial")
    let actionExpectation = expectation(description: "action")
    let actionExpectation2 = expectation(description: "action2")
    observableSUT.bindNoFire(self) { value in
      actionExpectation.fulfill()
      XCTAssertEqual(value, "new")
    }
    observableSUT.bindNoFire(self) { value in
      actionExpectation2.fulfill()
      XCTAssertEqual(value, "new")
    }
    observableSUT.value = "new"
    wait(for: [actionExpectation, actionExpectation2], timeout: 0.1)
  }

  func test_setValue_doesntCallActionOnUnboundObservers() {
    let observableSUT = Observable("initial")
    var invokeCount = 0
    observableSUT.bindNoFire(self) { _ in
      invokeCount += 1
    }
    observableSUT.value = "new"
    XCTAssertEqual(invokeCount, 1)
    observableSUT.unbind(self)
    observableSUT.value = "new2"
    XCTAssertEqual(invokeCount, 1)
  }

  func test_bind_callsActionWithInitialValue() {
    let observableSUT = Observable("initial")
    let actionExpectation = expectation(description: "action")
    observableSUT.bind(self) { value in
      actionExpectation.fulfill()
      XCTAssertEqual(value, "initial")
    }
    wait(for: [actionExpectation], timeout: 0.1)
  }
}


