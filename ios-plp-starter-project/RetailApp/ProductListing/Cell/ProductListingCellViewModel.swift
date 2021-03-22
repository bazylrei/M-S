import UIKit

class ProductListingCellViewModel {
  let priceFormatter: PriceFormatter
  let imageService: ImageService
  
  let name = Observable<String>("")
  let image = Observable<UIImage>(#imageLiteral(resourceName: "Placeholder"))
  let offerImage = Observable<UIImage>(#imageLiteral(resourceName: "Placeholder"))
  let price = Observable<NSAttributedString>(NSAttributedString(string: ""))
  
  var productDetails: ProductDetails? {
    didSet {
      guard let value = productDetails else {
        return
      }
      updateObservables(productDetails: value)
      downloadProductImage(productDetails: value)
    }
  }
  
  var offer: Offer? {
    didSet {
      guard let value = offer else {
        return
      }
      downloadOfferBadgeImage(offer: value)
    }
  }
  
  init(priceFormatter: PriceFormatter = PriceFormatterImplementation(),
       imageService: ImageService = ImageServiceImplementation()) {
    self.priceFormatter = priceFormatter
    self.imageService = imageService
  }
  
  private func updateObservables(productDetails: ProductDetails) {
    price.value = priceFormatter.formatPrice(productDetails.price)
    name.value = productDetails.name
  }

  private func downloadProductImage(productDetails: ProductDetails) {
    imageService.downloadImage(key: productDetails.imageKey) { [weak self] result in
      guard let self = self else {
        return
      }
      if let image = try? result.unwrapped() {
        self.image.value = image
      }
    }
  }
  
  private func downloadOfferBadgeImage(offer: Offer) {
    imageService.downloadBadge(name: offer.badge.name) { [weak self] result in
      guard let self = self else {
        return
      }
      if let image = try? result.unwrapped() {
        self.offerImage.value = image
      }
    }
  }
}
