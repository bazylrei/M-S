import Foundation

class OfferModel: Codable {
  let id: String
  let title: String
  let type: String
  var priority: Int?

  init(id: String, title: String, type: String, priority: Int, badge: Badge? = nil) {
    self.id = id
    self.title = title
    self.type = type
    self.priority = priority
  }
}
