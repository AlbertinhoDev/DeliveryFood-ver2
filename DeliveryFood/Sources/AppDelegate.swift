import Navigation
import UIKit

@UIApplicationMain //точка входа в программу
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let coordinator = AppCoordinator()
        coordinator.start()
        self.coordinator = coordinator
        return true
    }
}
