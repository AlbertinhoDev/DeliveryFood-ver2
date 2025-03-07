import Core
import Foundation

extension Profile.Screen.Profile {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let apiService: Profile.APIServicable
        
        init(apiService: Profile.APIServicable) {
            self.apiService = apiService
        }
    }
}

extension Profile.Screen.Profile.Presenter: Profile.Screen.Profile.PresentationLogic {
    func didTapLogoutButton() {
        router?.finishFlow()
    }
    
    func viewDidLoad() {
        Task {
            do {
                let response = try await apiService.getUser()
                await MainActor.run {
                    print(response.username)
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                    router?.finishFlow()
                }
            }
        }
    }
}
