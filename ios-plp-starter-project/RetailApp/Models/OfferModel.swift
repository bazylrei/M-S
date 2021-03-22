import Foundation

class OfferModel: Codable {
  let id: String
  let title: String
  let type: String
  var priority: Int?
}
