import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.makeKeyAndVisible()
    
    let productListingVC = ProductListingViewController()
    window!.rootViewController = UINavigationController(rootViewController: productListingVC)
    return true
  }
}
