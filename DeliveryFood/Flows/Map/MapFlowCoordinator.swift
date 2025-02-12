import Navigation
import UIKit

extension Map {
    public final class FlowCoordinator: Navigation.CoordinatorOutput {
        public var finishFlow: (() -> Void)?
        
        private let router: Navigation.Router
        private let screenBuilder: Map.ScreenBuildable
        private let diContainer: Map.DiContainerable
        
        public init(
            router: Navigation.Router,
            screenBuilder: Map.ScreenBuildable = Map.ScreenBuilder(),
            diContainer: Map.DiContainerable = Map.DiContainer()
        ) {
            self.router = router
            self.screenBuilder = screenBuilder
            self.diContainer = diContainer
        }
    }
}

extension Map.FlowCoordinator: Navigation.Coordinator { //NameSpacing
    public func start() {
        let viewController = screenBuilder.makeMapViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Map.FlowCoordinator: Map.Screen.Map.RoutingLogic {
    public func showCatalogScreen() {
        finishFlow?()
    }
}
