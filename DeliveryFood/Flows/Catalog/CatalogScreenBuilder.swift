import Core
import UIKit

extension Catalog {
    public protocol ScreenBuildable {
        func makeCatalogViewController(router: Screen.Catalog.RoutingLogic, diContainer: Catalog.DiContainerable) -> UIViewController
        func makeProductViewController(router: Screen.Product.RoutingLogic, diContainer: Catalog.DiContainerable, product: ProductModel) -> UIViewController
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
        let presenter = Catalog.Screen.Catalog.Presenter(cartManager: diContainer.cartManager)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }

    public func makeProductViewController(
        router: Catalog.Screen.Product.RoutingLogic,
        diContainer: Catalog.DiContainerable,
        product: ProductModel
    ) -> UIViewController {
        let viewController = Catalog.Screen.Product.ViewController()
        let presenter = Catalog.Screen.Product.Presenter(product: product, cartManager: diContainer.cartManager)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
