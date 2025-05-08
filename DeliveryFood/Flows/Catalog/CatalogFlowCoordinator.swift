import Core
import Navigation
import UIKit

extension Catalog {
    public final class FlowCoordinator: Navigation.CoordinatorOutput {
        public var onFinishFlow: (() -> Void)?
        
        private let router: Navigation.Router
        private let screenBuilder: Catalog.ScreenBuildable
        private let diContainer: Catalog.DiContainerable
        
        public init(
            router: Navigation.Router,
            screenBuilder: Catalog.ScreenBuildable = Catalog.ScreenBuilder(),
            diContainer: Catalog.DiContainerable
        ) {
            self.router = router
            self.screenBuilder = screenBuilder
            self.diContainer = diContainer
        }
    }
}

extension Catalog.FlowCoordinator: Navigation.Coordinator {
    public func start() {
        let viewController = screenBuilder.makeCatalogViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Catalog.FlowCoordinator: BackRoutingLogic {
    public func back() {
        router.pop(animated: true)
    }
}

extension Catalog.FlowCoordinator: Catalog.Screen.Catalog.RoutingLogic {
    public func showMapScreen() {
        onFinishFlow?()
    }
    
    public func showProductScreen(product: ProductModel) {
        let viewController = screenBuilder.makeProductViewController(router: self, diContainer: diContainer, product: product)
//        router.present(viewController: viewController, animated: true)
        router.push(viewController, animated: true)
    }
}

extension Catalog.FlowCoordinator: Catalog.Screen.Product.RoutingLogic {

}
