import UIKit

extension Profile {
    public protocol ScreenBuildable {
        func makeProfileViewController(router: Profile.Screen.Profile.RoutingLogic, diContainer: Profile.DiContainerable) -> UIViewController
    }
}

extension Profile {
    public final class ScreenBuilder {
        public init() {}
    }
}

extension Profile.ScreenBuilder: Profile.ScreenBuildable {
    public func makeProfileViewController(router: Profile.Screen.Profile.RoutingLogic, diContainer: Profile.DiContainerable) -> UIViewController {
        let viewController = Profile.Screen.Profile.ViewController()
        let presenter = Profile.Screen.Profile.Presenter(apiService: diContainer.apiService)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.router = router
        
        return viewController
    }
}
