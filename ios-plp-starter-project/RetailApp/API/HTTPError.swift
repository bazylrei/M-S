import Foundation

enum HTTPError: Error {
  case noResponse
  case requestError(Error)
  case invalidResponse(URLResponse)
  case unsuccessful(statusCode: Int, urlResponse: HTTPURLResponse, error: Error?)

  var localizedDescription: String {
    switch self {
    case .noResponse:
      return "No Response"
    case .requestError(let error):
      return "Request Error: \(error)"
    case .invalidResponse(let response):
      return "Invalid response. Expected HTTPURLResponse got \(type(of: response))"
    case .unsuccessful(let statusCode, _, _):
      return "Unsuccessful. Status code: \(statusCode)"
    }
  }
}
