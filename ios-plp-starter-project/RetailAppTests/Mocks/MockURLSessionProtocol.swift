import Foundation
@testable import RetailApp

struct ResumableStub: Resumable {
  func resume() {}
}

class MockURLSessionProtocol: URLSessionProtocol {
  private let urlSession = URLSession(configuration: .default)
  var lastRequest: URLRequest? = nil
  var lastCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil
  func resumableDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Resumable {
    lastRequest = request
    lastCompletionHandler = completionHandler
    return ResumableStub()
  }
}
