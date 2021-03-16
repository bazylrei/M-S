import UIKit

enum ImageDecodingError: Error {
  case badData
}

protocol ImageService {
  func downloadImage(key: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class ImageServiceImplementation: ImageService {
  private let api: API

  init(api: API) {
    self.api = api
  }

  func downloadImage(key: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
    let resource = Resource(path: "image/\(key).jpg", body: nil, method: "GET") { data -> Result<UIImage, Error> in
      guard let image = UIImage(data: data) else {
        return .error(ImageDecodingError.badData)
      }
      return .value(image)
    }
    api.load(resource, completion: completion)
  }
}
