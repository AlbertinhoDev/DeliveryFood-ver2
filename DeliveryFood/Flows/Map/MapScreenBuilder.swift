import UIKit

extension Map {
    public protocol ScreenBuildable {
        func makeMapViewController(router: Screen.Map.RoutingLogic, diContainer: Map.DiContainerable) -> UIViewController
    }
}

extension Map {
    public final class ScreenBuilder{
        public init() {}
    }
}

extension Map.ScreenBuilder: Map.ScreenBuildable {
    public func makeMapViewController(router: Map.Screen.Map.RoutingLogic, diContainer: Map.DiContainerable) -> UIViewController {
        let viewController = Map.Screen.Map.ViewController()
        let presenter = Map.Screen.Map.Presenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
