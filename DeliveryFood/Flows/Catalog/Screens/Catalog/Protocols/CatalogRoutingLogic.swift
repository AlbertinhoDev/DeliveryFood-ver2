import Core
import Navigation

extension Catalog.Screen.Catalog {
    public protocol RoutingLogic: BackRoutingLogic {
        func showMapScreen()
        func showProductScreen(product: ProductModel)
    }
}
