import UIKit

private class Dimensions {
  static let horizontalMargin: CGFloat = 5.0
  static let imageToTitleMargin: CGFloat = 8.0
  static let titleToPriceMargin: CGFloat = 15.0
}

class ProductListingCell: UICollectionViewCell {
  static let identifier = String(describing: ProductListingCell.self)
  let viewModel: ProductListingCellViewModel
  
  let imageView = UIImageView()
  let titleLabel = UILabel()
  let priceLabel = UILabel()
  
  override init(frame: CGRect) {
    self.viewModel = ProductListingCellViewModel()
    super.init(frame: frame)
    setupLayout()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with productDetails: ProductDetails) {
    viewModel.productDetails = productDetails
  }
  
  private func bind() {
    viewModel.name.bind(self) { [weak self] name in
      self?.titleLabel.text = name
    }
    viewModel.price.bind(self) { [weak self] price in
      self?.priceLabel.attributedText = price
    }
    viewModel.image.bind(self) { [weak self] image in
      self?.imageView.image = image
    }
  }
  
  private func setupLayout() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(priceLabel)
    priceLabel.translatesAutoresizingMaskIntoConstraints = false

    backgroundColor = .blue
    clipsToBounds = true
    imageView.contentMode = .scaleAspectFit
    let centerImageXConstraint = NSLayoutConstraint(item: imageView,
                                               attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .centerX,
                                               multiplier: 1.0,
                                               constant: 0.0)
    let widthImageConstraint = NSLayoutConstraint(item: imageView,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: contentView,
                                             attribute: .width,
                                             multiplier: 1.0,
                                             constant: 0.0)
    let heightImageConstraint = NSLayoutConstraint(item: imageView,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: imageView,
                                             attribute: .width,
                                             multiplier: 1.5,
                                             constant: 0.0)
    let topImageConstraint = NSLayoutConstraint(item: imageView,
                                               attribute: .topMargin,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .topMargin,
                                               multiplier: 1.0,
                                               constant: 0.0)
    let topTitleLabelConstraint = NSLayoutConstraint(item: titleLabel,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: imageView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: Dimensions.imageToTitleMargin)
    let leftTitleLabelConstraint = NSLayoutConstraint(item: titleLabel,
                                                      attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: Dimensions.horizontalMargin)
//    let topPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
//                                                     attribute: .top,
//                                                     relatedBy: .equal,
//                                                     toItem: titleLabel,
//                                                     attribute: .bottom,
//                                                     multiplier: 1.0,
//                                                     constant: Dimensions.titleToPriceMargin)
    let leftPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                      attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: Dimensions.horizontalMargin)
    let bottomPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0.0)
    
    
    contentView.addConstraints([centerImageXConstraint,
                                widthImageConstraint,
                                heightImageConstraint,
                                topImageConstraint,
                                topTitleLabelConstraint,
                                leftTitleLabelConstraint,
//                                topPriceLabelConstraint,
                                leftPriceLabelConstraint,
                                bottomPriceLabelConstraint])
  }
  
}
