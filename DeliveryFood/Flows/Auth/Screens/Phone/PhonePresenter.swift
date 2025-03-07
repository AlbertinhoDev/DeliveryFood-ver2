import Core
import Foundation

extension Auth.Screen.Phone {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let apiService: Auth.APIServicable
        
        init(apiService: Auth.APIServicable) {
            self.apiService = apiService
        }
    }
}

extension Auth.Screen.Phone.Presenter: Auth.Screen.Phone.PresentationLogic {
    func didTapButton() {
        router?.showCodeScreen()
    }
}
