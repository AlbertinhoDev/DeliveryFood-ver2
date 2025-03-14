import Auth
import Catalog
import Navigation
import Profile
import UIKit

final class TabBarCoordinator: CoordinatorOutput {
    var onFinishFlow: (() -> Void)?
    
    private let router: Router
    private let tabBarController = UITabBarController()
    private let isUserAuth = false
    
    init(router: Router) {
        self.router = router
    }
    
    private func setupTabBarController() {
        var viewControllers: [UIViewController] = []
        
        TabType.allCases.forEach { type in
            let navigationController = makeNavigationController(for: type)
            let router = NavigationRouter(navigtionController: navigationController)
            
            switch type {
            case .catalog:
                startCatalogFlow(router: router)
//            case .cart:
//                startCartFlow(router: router)
            case .profile:
                if isUserAuth {
                    startProfileFlow(router: router)
                } else {
                    startAuthFlow(router: router)
                }
            }
            
            viewControllers.append(navigationController)
        }
        
        tabBarController.viewControllers = viewControllers
    }
    
    private func startCatalogFlow(router: Router) {
        let catalogCoordinator = Catalog.FlowCoordinator(router: router)
        catalogCoordinator.onFinishFlow = onFinishFlow
        catalogCoordinator.start()
    }
    
//    private func startCartFlow(router: Router) {
//        let cartCoordinator = Catalog.FlowCoordinator(router: router)
//        cartCoordinator.onFinishFlow = { [unowned self] in
//            startOrderFlow(router: router)
//        }
//        cartCoordinator.start()
//    }
//    
//    private func startOrderFlow(router: Router) {
//        let cartCoordinator = Catalog.FlowCoordinator(router: router)
//        cartCoordinator.onFinishFlow = { [unowned self] in
//            tabBarController.selectedIndex = .zero
//            startCartFlow(router: router)
//        }
//        cartCoordinator.start()
//    }
    
    private func startAuthFlow(router: Router) {
        let authCoordinator = Auth.FlowCoordinator(router: router)
        authCoordinator.onFinishFlow = { [unowned self] in
            startProfileFlow(router: router)
        }
        authCoordinator.start()
    }
    
    private func startProfileFlow(router: Router) {
        let profileCoordinator = Profile.FlowCoordinator(router: router)
        profileCoordinator.onFinishFlow = { [unowned self] in
            startAuthFlow(router: router)
        }
        profileCoordinator.start()
    }
    
    private func makeNavigationController(for type: TabType) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem.title = type.title
        navigationController.tabBarItem.image = UIImage(systemName: type.imageName)
        
        return navigationController
    }
    
}

extension TabBarCoordinator: Coordinator {
    func start() {
        setupTabBarController()
        router.push(tabBarController, animated: true)
    }
}
