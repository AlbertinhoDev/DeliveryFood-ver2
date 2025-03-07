import Map
import Navigation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let router: Router
    private var currentCoordinator: Coordinator?
    
    init() {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        let router = NavigationRouter(navigtionController: navigationController)
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        self.router = router
    }
    private func startMapFlow() {
        let mapCoordinator = Map.FlowCoordinator(router: router)
        mapCoordinator.onFinishFlow = { [unowned self] in
            currentCoordinator = nil
            startTabBarFlow()
        }
        mapCoordinator.start()
        currentCoordinator = mapCoordinator
    }
    
    private func startTabBarFlow() {
        let tabBarCoordinator = TabBarCoordinator(router: router)
        tabBarCoordinator.onFinishFlow = { [unowned self] in
            currentCoordinator = nil
            router.pop(animated: true)
        }
        tabBarCoordinator.start()
        currentCoordinator = tabBarCoordinator
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        startMapFlow()
    }
}

