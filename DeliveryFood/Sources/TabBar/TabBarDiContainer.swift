import Catalog
import Core
import Foundation

protocol TabBarDiContainerable {
    var cartManager: CartManagable { get }
}

final class TabBarDiContainer: TabBarDiContainerable {
    let cartManager: CartManagable
    
    init(cartManager: CartManagable = CartManager()) {
        self.cartManager = cartManager
    }
}
