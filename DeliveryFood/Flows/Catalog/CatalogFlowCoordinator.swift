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
            diContainer: Catalog.DiContainerable = Catalog.DiContainer()
        ) {
            self.router = router
            self.screenBuilder = screenBuilder
            self.diContainer = diContainer
        }
    }
}

extension Catalog.FlowCoordinator: Navigation.Coordinator {
    public func start() {
        let viewController = screenBuilder.makeProductViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Catalog.FlowCoordinator: BackRoutingLogic {
    public func back() {
        router.pop(animated: true)
    }
}

extension Catalog.FlowCoordinator: Catalog.Screen.Product.RoutingLogic {
    public func showMapScreen() {
        onFinishFlow?()
    }
    
    public func showPromotionScreen() {
        let viewController = screenBuilder.makeProductViewController(router: self, diContainer: diContainer)
        router.present(viewController: viewController, animated: true)
    }
}
