import Core
import UIKit

extension Catalog {
    public protocol DiContainerable {
        var cartManager: CartManagable { get }
    }
}

extension Catalog {
    public final class DiContainer: DiContainerable {
        public var cartManager: CartManagable
        
        public init(cartManager: CartManagable) {
            self.cartManager = cartManager
        }
        
    }
}
