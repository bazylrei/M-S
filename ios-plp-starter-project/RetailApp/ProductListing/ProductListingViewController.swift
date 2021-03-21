import UIKit

private let reuseIdentifier = ProductListingCell.identifier

class ProductListingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  private var collectionView: UICollectionView?
  private let router: Routing
  private let viewModel: ProductListingViewModel
  
  init(router: Routing,
       viewModel: ProductListingViewModel) {
    self.router = router
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupCollectionView()
    bind()
  }
  
  private func bind() {
    viewModel.productDetails.bind(self) { [weak self] price in
      self?.attemptReload()
    }
    viewModel.appSetup.offers.bind(self) { [weak self] offers in
      self?.attemptReload()
    }
  }
  
  private func attemptReload() {
    guard let _ = viewModel.productDetails.value else {
      print("product details are wrong")
      return
    }
    guard let _ = viewModel.appSetup.offers.value else {
      print("offers are wrong")
      return
    }
    self.collectionView?.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.numberOfProducts
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductListingCell else {
      fatalError("Loaded invalid cell")
    }
    let product = viewModel.product(at: indexPath.row)
    let badge = viewModel.badgeForProduct(at: indexPath.row)
    cell.setup(with: product, offerBadge: badge)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let product = viewModel.product(at: indexPath.row)
    let viewModel = ProductDetailsViewModel(productRequest: product, listingImage: nil)
    let productDetailsViewController = ProductDetailsViewController(viewModel: viewModel)
    router.push(viewController: productDetailsViewController)
  }
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = cellSize
    layout.minimumInteritemSpacing = Dimensions.horizontalMargin
    layout.minimumLineSpacing = Dimensions.horizontalMargin
    collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    guard let collectionView = collectionView else {
      print("Failed to initialise collectionview")
      return
    }
    collectionView.register(ProductListingCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = .white
    collectionView.showsVerticalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.delegate = self
    view.addSubview(collectionView)
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    let centerXConstraint = NSLayoutConstraint(item: collectionView,
                                               attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .centerX,
                                               multiplier: 1.0,
                                               constant: 0.0)
    let bottomConstraint = NSLayoutConstraint(item: collectionView,
                                              attribute: .bottomMargin,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .bottomMargin,
                                              multiplier: 1.0,
                                              constant: 0.0)
    let leadingConstraint = NSLayoutConstraint(item: collectionView,
                                               attribute: .leadingMargin,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .leadingMargin,
                                               multiplier: 1.0,
                                               constant: 0)
    let topConstraint = NSLayoutConstraint(item: collectionView,
                                           attribute: .topMargin,
                                           relatedBy: .equal,
                                           toItem: view,
                                           attribute: .topMargin,
                                           multiplier: 1.0,
                                           constant: Dimensions.navigationBarTopInset)
    view.addConstraints([centerXConstraint,
                         bottomConstraint,
                         leadingConstraint,
                         topConstraint])
  }
  
  private lazy var cellSize: CGSize = {
    let width: CGFloat = (view.frame.width - 5 * Dimensions.horizontalMargin) / 2.0
    let height: CGFloat = view.frame.height / 2.0
    return CGSize(width: width, height: height)
  }()
}

private class Dimensions {
  static let horizontalMargin: CGFloat = 5.0
  static let navigationBarTopInset: CGFloat = 20.0
}
