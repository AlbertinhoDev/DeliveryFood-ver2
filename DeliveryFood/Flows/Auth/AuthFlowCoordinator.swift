import Navigation
import UIKit

extension Auth {
    public final class FlowCoordinator: Navigation.CoordinatorOutput {
        public var onFinishFlow: (() -> Void)?
        
        private let router: Navigation.Router
        private let screenBuilder: Auth.ScreenBuildable
        private let diContainer: Auth.DiContainerable
        
        public init(
            router: Navigation.Router,
            screenBuilder: Auth.ScreenBuildable = Auth.ScreenBuilder(),
            diContainer: Auth.DiContainerable = Auth.DiContainer()
        ) {
            self.router = router
            self.screenBuilder = screenBuilder
            self.diContainer = diContainer
        }
    }
}

extension Auth.FlowCoordinator: Navigation.Coordinator {
    public func start() {
        let viewController = screenBuilder.makePhoneViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Auth.FlowCoordinator: FinishFlowRoutingLogic {
    public func finishFlow() {
        onFinishFlow?()
    }
}

extension Auth.FlowCoordinator: Auth.Screen.Phone.RoutingLogic {
    public func showCodeScreen() {
        let viewController = screenBuilder.makeCodeViewController(router: self, diContainer: diContainer)
        router.push(viewController, animated: true)
    }
}

extension Auth.FlowCoordinator: Auth.Screen.Code.RoutingLogic {}


