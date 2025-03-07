extension Catalog.Screen.Product {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
    }
}

extension Catalog.Screen.Product.Presenter: Catalog.Screen.Product.PresentationLogic {
    func didTapButton() {
        router?.showMapScreen()
    }
    
    func didTapPromotion() {
        router?.showPromotionScreen()
    }
    
    func didTapBackButton() {
        router?.back()
    }
}
