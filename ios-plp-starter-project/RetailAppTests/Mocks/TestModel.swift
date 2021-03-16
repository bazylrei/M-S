import Foundation

struct TestModel: Decodable, Equatable {
  let value: Int
  static var data = Data(bytes: "{\"value\": 1}".utf8)
  static var model = TestModel(value: 1)
}
