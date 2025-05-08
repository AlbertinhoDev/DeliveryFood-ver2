import Core

extension Catalog.Screen.Product {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private let product: ProductModel
        private let cartManager: CartManagable
        
        init(product: ProductModel, cartManager: CartManagable) {
            self.product = product
            self.cartManager = cartManager
            print(product.title)
        }
    }
}

extension Catalog.Screen.Product.Presenter: Catalog.Screen.Product.PresentationLogic {
    func didTapButton() {
        router?.showMapScreen()
    }
    
    func didTapAddProduct() {
//        router?.showPromotionScreen()
        cartManager.add(product: product)
    }
    
    func didTapBackButton() {
        router?.back()
    }
}
