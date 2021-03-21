import UIKit

protocol Routing {
  func push(viewController: UIViewController)
}

class Router: Routing {
  private var navigationController: UINavigationController
  private var window: UIWindow?
  
  init() {
    self.navigationController = UINavigationController()
    initiate(with: navigationController)
  }
  
  func push(viewController: UIViewController) {
    navigationController.pushViewController(viewController, animated: true)
  }
  
  private func initiate(with navigationController: UINavigationController) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.makeKeyAndVisible()
    window!.rootViewController = navigationController
  }
}
