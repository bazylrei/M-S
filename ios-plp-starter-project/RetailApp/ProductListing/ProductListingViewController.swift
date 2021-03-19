import UIKit

private let reuseIdentifier = "ProductListingCell"

class ProductListingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  
  private var collectionView: UICollectionView?
  private let viewModel: ProductListingViewModel
  
  init(viewModel: ProductListingViewModel = ProductListingViewModel()) {
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
      self?.collectionView?.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.numberOfProducts
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ProductListingCell else {
      fatalError("Loaded invalid cell")
    }
    cell.backgroundColor = .black
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let product = viewModel.product(at: indexPath.row)
    let viewModel = ProductDetailsViewModel(productRequest: product, listingImage: nil)
    let viewController = ProductDetailsViewController(viewModel: viewModel)
    self.navigationController?.pushViewController(viewController, animated: true)
  }

  private func setupCollectionView() {
      let layout = UICollectionViewFlowLayout()
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
                                             constant: 0)
      view.addConstraints([centerXConstraint,
                           bottomConstraint,
                           leadingConstraint,
                           topConstraint])
  }
}

extension ProductDetailsViewController {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 100, height: 60)
  }
}
