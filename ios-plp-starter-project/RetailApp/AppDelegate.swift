import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  let router: Routing = Router()
  let appSetup = AppSetup()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    appSetup.initiate()
    let viewModel = ProductListingViewModel(appSetup: appSetup)
    let productListingVC = ProductListingViewController(router: router, viewModel: viewModel)
    router.push(viewController: productListingVC)
    return true
  }
}
