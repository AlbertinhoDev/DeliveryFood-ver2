import Catalog
import Map
import Navigation
import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let router: Router
    
    init() {
        let navigationController = UINavigationController()
        let router = NavigationRouter(navigtionController: navigationController)
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        self.router = router
    }
    private func startMapFlow() {
        let mapCoordinator = Map.FlowCoordinator(router: router)
        mapCoordinator.finishFlow = { [unowned self] in
            startCatalogFlow()
        }
        mapCoordinator.start()
    }
    
    private func startCatalogFlow() {
        let catalogCoordinator = Catalog.FlowCoordinator(router: router)
        catalogCoordinator.finishFlow = { [unowned self] in
            startMapFlow()
        }
        catalogCoordinator.start()
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        startMapFlow()
    }
}
