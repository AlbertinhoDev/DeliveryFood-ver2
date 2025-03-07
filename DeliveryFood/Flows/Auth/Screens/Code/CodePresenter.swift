import Core
import Foundation

extension Auth.Screen.Code {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let apiService: Auth.APIServicable
        
        init(apiService: Auth.APIServicable) {
            self.apiService = apiService
        }
    }
}

extension Auth.Screen.Code.Presenter: Auth.Screen.Code.PresentationLogic {
    func didTapButton() {
        Task {
            do {
                let response = try await apiService.login(username: "emilys", password: "emilyspass")
                await MainActor.run {
                    print(response)
                    router?.finishFlow()
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
