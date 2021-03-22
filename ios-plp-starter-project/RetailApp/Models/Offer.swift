import Foundation

class Offer {
  let id: String
  var badge: Badge
  
  internal init(id: String, badge: Badge) {
    self.id = id
    self.badge = badge
  }
}
