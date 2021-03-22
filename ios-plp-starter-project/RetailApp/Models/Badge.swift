import UIKit

class Badge {
  let name: String
  let types: [String]
  var image: UIImage?
  var priority: Int
  
  internal init(name: String, types: [String], image: UIImage? = nil, priority: Int) {
    self.name = name
    self.types = types
    self.image = image
    self.priority = priority
  }
}
