import Navigation

extension Catalog.Screen.Product {
    public protocol RoutingLogic: BackRoutingLogic {
        func showMapScreen()
        func showPromotionScreen()
    }
}
