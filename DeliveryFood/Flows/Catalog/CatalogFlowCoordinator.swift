import Navigation
import UIKit

extension Catalog {
    public final class FlowCoordinator: Navigation.CoordinatorOutput {
        public var finishFlow: (() -> Void)?
        
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

extension Catalog.FlowCoordinator: Navigation.Coordinator { //NameSpacing
    public func start() {
        let viewController = screenBuilder.makeProductViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Catalog.FlowCoordinator: Catalog.Screen.Product.RoutingLogic {
    public func showMapScreen() {
        finishFlow?()
    }
}
