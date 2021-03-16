import Foundation

struct Resource<A> {
  let path: String
  let body: Data?
  let method: String
  let parse: (Data) -> Result<A, Error>
}

extension Resource where A: Decodable {
  init(path: String) {
    self.path = path
    self.method = "GET"
    self.body = nil
    parse = { data in
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return .value(try decoder.decode(A.self, from: data))
      } catch {
        return .error(error)
      }
    }
  }
}
