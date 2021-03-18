import UIKit

private let reuseIdentifier = "Cell"

class ProductListingViewController: UICollectionViewController {
  
  private let viewModel: ProductListingViewModel
  
  init(viewModel: ProductListingViewModel = ProductListingViewModel()) {
    self.viewModel = viewModel
    let collectionViewLayout = UICollectionViewFlowLayout()
    super.init(collectionViewLayout: collectionViewLayout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    bind()
  }
  
  private func bind() {
    viewModel.productDetails.bind(self) { [weak self] price in
      self?.collectionView.reloadData()
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    viewModel.numberOfSections
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.numberOfProducts
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    return cell
  }
}
