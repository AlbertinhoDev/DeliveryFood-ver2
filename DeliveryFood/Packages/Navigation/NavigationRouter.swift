import UIKit

public final class NavigationRouter {
    private let navigtionController: UINavigationController
    
    public init(navigtionController: UINavigationController) {
        self.navigtionController = navigtionController
    }
}
extension NavigationRouter: Router {
    public func push(_ viewController: UIViewController, animated: Bool) {
        navigtionController.pushViewController(viewController, animated: animated)
    }
    
    public func pop(animated: Bool) {
        navigtionController.popViewController(animated: animated)
    }
    
    public func setRoot(viewController: UIViewController, animated: Bool) {
        navigtionController.setViewControllers([viewController], animated: animated)
    }
    
    public func present(viewController: UIViewController, animated: Bool) {
        navigtionController.present(viewController, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        navigtionController.dismiss(animated: animated)
    }
}
