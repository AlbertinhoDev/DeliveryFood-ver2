import UIKit

extension Catalog {
    public protocol ScreenBuildable {
        func makeCatalogViewController(router: Screen.Catalog.RoutingLogic, diContainer: Catalog.DiContainerable) -> UIViewController
        func makeProductViewController(router: Screen.Product.RoutingLogic, diContainer: Catalog.DiContainerable) -> UIViewController
    }
}

extension Catalog {
    public final class ScreenBuilder{
        public init() {}
    }
}

extension Catalog.ScreenBuilder: Catalog.ScreenBuildable {
    public func makeCatalogViewController(router: Catalog.Screen.Catalog.RoutingLogic, diContainer: Catalog.DiContainerable) -> UIViewController {
        let viewController = Catalog.Screen.Catalog.ViewController()
        let presenter = Catalog.Screen.Catalog.Presenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }

    public func makeProductViewController(router: Catalog.Screen.Product.RoutingLogic, diContainer: Catalog.DiContainerable) -> UIViewController {
        let viewController = Catalog.Screen.Product.ViewController()
        let presenter = Catalog.Screen.Product.Presenter()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
