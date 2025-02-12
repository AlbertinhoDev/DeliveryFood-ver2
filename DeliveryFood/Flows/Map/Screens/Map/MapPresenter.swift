extension Map.Screen.Map {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
    }
}

extension Map.Screen.Map.Presenter: Map.Screen.Map.PresentationLogic {
    func didTapButton() {
        router?.showCatalogScreen()
    }
}
