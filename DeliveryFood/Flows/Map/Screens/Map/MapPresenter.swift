import Foundation
import Core

extension Map.Screen.Map {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let apiService: AuthAPIServicable
        
        init(apiService: AuthAPIServicable) {
            self.apiService = apiService
        }
    }
}

extension Map.Screen.Map.Presenter: Map.Screen.Map.PresentationLogic {
    func didTapButton1() {
        Task {
            do {
                let response = try await apiService.login(username: "emilys", password: "emilyspass")
                await MainActor.run {
                    print(response)
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    func didTapButton2() {
        Task {
            do {
                let response = try await apiService.getUser()
                await MainActor.run {
                    print(response)
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func didTapButton3() {
        print(#function)
    }
    
    func didTapButton() {
        router?.showCatalogScreen()
    }
}

