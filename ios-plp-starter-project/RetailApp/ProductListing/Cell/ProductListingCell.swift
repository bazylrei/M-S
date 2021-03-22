import UIKit


class ProductListingCell: UICollectionViewCell {
  static let identifier = String(describing: ProductListingCell.self)
  let viewModel: ProductListingCellViewModel
  
  let imageView = UIImageView()
  let offerImageView = UIImageView()
  let titleLabel = UITextView()
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
  
  func setup(with productDetails: ProductDetails, offer: Offer?) {
    viewModel.productDetails = productDetails
    viewModel.offer = offer
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
    viewModel.offerImage.bind(self) { [weak self] image in
      self?.offerImageView.image = image
    }
  }
  
  private func setupLayout() {
    titleLabel.font = UIFont.systemFont(ofSize: 13.0)
    titleLabel.contentInset = UIEdgeInsets(top: -7, left: 0, bottom: 0, right: 0)
    titleLabel.textContainer.maximumNumberOfLines = 2
    titleLabel.textContainer.lineBreakMode = .byTruncatingTail
    titleLabel.isUserInteractionEnabled = false
    priceLabel.font = UIFont.systemFont(ofSize: 13.0)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(priceLabel)
    priceLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(offerImageView)
    offerImageView.translatesAutoresizingMaskIntoConstraints = false
    offerImageView.contentMode = .scaleAspectFit
    offerImageView.clipsToBounds = true
    
    clipsToBounds = true
    let leadingImageConstraint = NSLayoutConstraint(item: imageView,
                                               attribute: .leading,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .leading,
                                               multiplier: 1.0,
                                               constant: 0.0)
    let trailingImageConstraint = NSLayoutConstraint(item: imageView,
                                             attribute: .trailing,
                                             relatedBy: .equal,
                                             toItem: contentView,
                                             attribute: .trailing,
                                             multiplier: 1.0,
                                             constant: 0.0)
    let topImageConstraint = NSLayoutConstraint(item: imageView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: contentView,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 0.0)
    let topTitleLabelToImageConstraint = NSLayoutConstraint(item: titleLabel,
                                                     attribute: .topMargin,
                                                     relatedBy: .equal,
                                                     toItem: imageView,
                                                     attribute: .bottomMargin,
                                                     multiplier: 1.0,
                                                     constant: Dimensions.imageToTitleMargin)
    
    let leftTitleLabelConstraint = NSLayoutConstraint(item: titleLabel,
                                                      attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: Dimensions.horizontalMargin)
    let rightTitleLabelConstraint = NSLayoutConstraint(item: titleLabel,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: contentView,
                                                       attribute: .trailing,
                                                       multiplier: 1.0,
                                                       constant: -Dimensions.horizontalMargin)
    let heightTitleLabelConstraint = NSLayoutConstraint(item: titleLabel,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: 2 * Dimensions.labelHeight)
    let topPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: titleLabel,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: Dimensions.titleToPriceMargin)
    let leftPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                      attribute: .leading,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .leading,
                                                      multiplier: 1.0,
                                                      constant: Dimensions.horizontalMargin)
    let rightPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                      attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .trailing,
                                                      multiplier: 1.0,
                                                      constant: -Dimensions.horizontalMargin)
    let heightPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: Dimensions.labelHeight)
    let bottomPriceLabelConstraint = NSLayoutConstraint(item: priceLabel,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: contentView,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 0.0)
    let widthOfferImageConstraint = NSLayoutConstraint(item: offerImageView,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: Dimensions.offerImageWidth)
    let heightOfferImageConstraint = NSLayoutConstraint(item: offerImageView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: Dimensions.offerImageHeight)
    let rightOfferImageConstraint = NSLayoutConstraint(item: offerImageView,
                                                      attribute: .trailing,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .trailing,
                                                      multiplier: 1.0,
                                                      constant: -Dimensions.horizontalMargin)
    let topOfferImageConstraint = NSLayoutConstraint(item: offerImageView,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: contentView,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: Dimensions.verticalMargin)
    contentView.addConstraints([leadingImageConstraint,
                                trailingImageConstraint,
                                topImageConstraint,
                                topTitleLabelToImageConstraint,
                                leftTitleLabelConstraint,
                                rightTitleLabelConstraint,
                                heightTitleLabelConstraint,
                                topPriceLabelConstraint,
                                leftPriceLabelConstraint,
                                rightPriceLabelConstraint,
                                heightPriceLabelConstraint,
                                bottomPriceLabelConstraint,
                                widthOfferImageConstraint,
                                heightOfferImageConstraint,
                                rightOfferImageConstraint,
                                topOfferImageConstraint
    ])
  }
  
}
private class Dimensions {
  static let horizontalMargin: CGFloat = 5.0
  static let verticalMargin: CGFloat = 5.0
  static let imageToTitleMargin: CGFloat = 18.0
  static let titleToPriceMargin: CGFloat = 8.0
  static let labelHeight: CGFloat = 20.0
  static let offerImageHeight: CGFloat = 20.0
  static let offerImageWidth: CGFloat = 50.0
}
