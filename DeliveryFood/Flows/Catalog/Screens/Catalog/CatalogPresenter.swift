extension Catalog.Screen.Catalog {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
    }
}

extension Catalog.Screen.Catalog.Presenter: Catalog.Screen.Catalog.PresentationLogic {
    func viewDidLoad() {
        let sections: [Catalog.Screen.Catalog.Section]  = [
            .init(type: .promotions, rows: [.promotions]),
            .init(type: .categories, rows: [.categories]),
            .init(type: .products, rows: [.product, .product, .product, .product, .product])
        ]
        viewController?.update(sections: sections)
    }
    
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
