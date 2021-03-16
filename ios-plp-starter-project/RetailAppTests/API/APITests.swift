import XCTest
@testable import RetailApp


class APITests: XCTestCase {

  let url = URL(string: "http://www.marksandspencer.com")!

  func test_load_whenNoResponse_returnsNoResponseError() {
    let mockURLSession = MockURLSessionProtocol()
    let apiSUT = API(urlSession: mockURLSession, baseURL: url)

    let callbackExpectation = expectation(description: "updated")
    apiSUT.load(Resource<TestModel>(path: "")) { result in
      callbackExpectation.fulfill()
      guard case .error(let error) = result, let httpError = error as? HTTPError else {
        XCTFail("Should be error")
        return
      }
      guard case HTTPError.noResponse = httpError else {
        XCTFail("Should be .noResponse got \(httpError)")
        return
      }
    }
    mockURLSession.lastCompletionHandler?(nil, nil, nil)
    wait(for: [callbackExpectation], timeout: 0.1)
  }

  func test_load_whenError_returnsTheError() {
    let mockURLSession = MockURLSessionProtocol()
    let apiSUT = API(urlSession: mockURLSession, baseURL: url)


    let callbackExpectation = expectation(description: "updated")
    apiSUT.load(Resource<TestModel>(path: "")) { result in
      callbackExpectation.fulfill()
      guard case .error(let error) = result, let httpError = error as? HTTPError else {
        XCTFail("Should be error")
        return
      }
      guard case HTTPError.requestError(let theErrorToReturn) = httpError else {
        XCTFail("Should be .requestError got \(httpError)")
        return
      }
      guard let _ = theErrorToReturn as? ImageDecodingError else {
        XCTFail("Wrong error returned")
        return
      }
    }
    mockURLSession.lastCompletionHandler?(nil, URLResponse(), ImageDecodingError.badData)
    wait(for: [callbackExpectation], timeout: 0.1)
  }

  func test_load_whenNotHTTPURLResponse_returnsInvalidResponse() {
    let mockURLSession = MockURLSessionProtocol()
    let apiSUT = API(urlSession: mockURLSession, baseURL: url)


    let callbackExpectation = expectation(description: "updated")
    apiSUT.load(Resource<TestModel>(path: "")) { result in
      callbackExpectation.fulfill()
      guard case .error(let error) = result, let httpError = error as? HTTPError else {
        XCTFail("Should be error")
        return
      }
      guard case HTTPError.invalidResponse = httpError else {
        XCTFail("Should be .invalidResponse got \(httpError)")
        return
      }
    }
    mockURLSession.lastCompletionHandler?(nil, URLResponse(), nil)
    wait(for: [callbackExpectation], timeout: 0.1)
  }

  func test_load_whenStatusCode500_returnsUnsuccessful() {
    let mockURLSession = MockURLSessionProtocol()
    let apiSUT = API(urlSession: mockURLSession, baseURL: url)


    let callbackExpectation = expectation(description: "updated")
    apiSUT.load(Resource<TestModel>(path: "")) { result in
      callbackExpectation.fulfill()
      guard case .error(let error) = result, let httpError = error as? HTTPError else {
        XCTFail("Should be error")
        return
      }
      guard case HTTPError.unsuccessful(let statusCode, _, _) = httpError else {
        XCTFail("Should be .unsuccessful got \(httpError)")
        return
      }
      XCTAssertEqual(statusCode, 500)
    }
    mockURLSession.lastCompletionHandler?(nil, HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: [:]), nil)
    wait(for: [callbackExpectation], timeout: 0.1)
  }

  func test_load_whenSuccessfulRequest_returnsDecodedModel() {
    let mockURLSession = MockURLSessionProtocol()
    let apiSUT = API(urlSession: mockURLSession, baseURL: url)


    let callbackExpectation = expectation(description: "updated")
    apiSUT.load(Resource<TestModel>(path: "")) { result in
      callbackExpectation.fulfill()
      guard let model = try? result.unwrapped() else {
        XCTFail("Expected success got error")
        return
      }
      XCTAssertEqual(TestModel.model, model)
    }
    mockURLSession.lastCompletionHandler?(TestModel.data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: [:]), nil)
    wait(for: [callbackExpectation], timeout: 0.1)
  }
}
