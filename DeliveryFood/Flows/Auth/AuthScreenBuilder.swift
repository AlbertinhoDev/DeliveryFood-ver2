import UIKit

extension Auth {
    public protocol ScreenBuildable {
        func makePhoneViewController(router: Auth.Screen.Phone.RoutingLogic, diContainer: Auth.DiContainerable) -> UIViewController
        func makeCodeViewController(router: Auth.Screen.Code.RoutingLogic, diContainer: Auth.DiContainerable) -> UIViewController
    }
}

extension Auth {
    public final class ScreenBuilder {
        public init() {}
    }
}

extension Auth.ScreenBuilder: Auth.ScreenBuildable {
    public func makePhoneViewController(router: Auth.Screen.Phone.RoutingLogic, diContainer: Auth.DiContainerable) -> UIViewController {
        let viewController = Auth.Screen.Phone.ViewController()
        let presenter = Auth.Screen.Phone.Presenter(apiService: diContainer.apiService)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
    
    public func makeCodeViewController(router: Auth.Screen.Code.RoutingLogic, diContainer: Auth.DiContainerable) -> UIViewController {
        let viewController = Auth.Screen.Code.ViewController()
        let presenter = Auth.Screen.Code.Presenter(apiService: diContainer.apiService)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
