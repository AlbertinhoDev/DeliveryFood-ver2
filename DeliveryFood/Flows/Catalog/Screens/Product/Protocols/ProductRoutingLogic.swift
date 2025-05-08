import Navigation
import Core

extension Catalog.Screen.Product {
    public protocol RoutingLogic: BackRoutingLogic {
        func showMapScreen()
        func showProductScreen(product: ProductModel)
    }
}
