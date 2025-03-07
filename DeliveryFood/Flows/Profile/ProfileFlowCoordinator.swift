import Navigation
import UIKit

extension Profile {
    public final class FlowCoordinator: Navigation.CoordinatorOutput {
        public var onFinishFlow: (() -> Void)?
        
        private let router: Navigation.Router
        private let screenBuilder: Profile.ScreenBuildable
        private let diContainer: Profile.DiContainerable
        
        public init(
            router: Navigation.Router,
            screenBuilder: Profile.ScreenBuildable = Profile.ScreenBuilder(),
            diContainer: Profile.DiContainerable = Profile.DiContainer()
        ) {
            self.router = router
            self.screenBuilder = screenBuilder
            self.diContainer = diContainer
        }
        
    }
}

extension Profile.FlowCoordinator: Navigation.Coordinator {
    public func start() {
        let viewController = screenBuilder.makeProfileViewController(router: self, diContainer: diContainer)
        router.setRoot(viewController: viewController, animated: true)
    }
}

extension Profile.FlowCoordinator: FinishFlowRoutingLogic {
    public func finishFlow() {
        onFinishFlow?()
    }
}

extension Profile.FlowCoordinator: Profile.Screen.Profile.RoutingLogic {}
