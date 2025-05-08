import Foundation

public enum CurrencyType: Int {
    case rub = 0
    
    public var title: String {
        switch self {
        case .rub:
            return "руб"
        }
    }
}

public struct ProductModel {
    public let id: String
    public let title: String
    public let subtitle: String
    public let price: Int
    public let currency: CurrencyType
    public var count: Int
    
    public init(id: String, title: String, subtitle: String, price: Int, currency: CurrencyType, count: Int) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.currency = currency
        self.count = count
    }
    
    public mutating func plus() {
        count += 1
    }
    
    public mutating func minus() {
        guard count > 0 else {
            return
        }
        count -= 1
    }
}

public protocol CartManagable {
    func add(product: ProductModel)
    func remove(product: ProductModel)
    func removeAll()
}

public final class CartManager {
    private(set) var products: [ProductModel] = []
    
    public init() {}
}

extension CartManager: CartManagable {
    public func add(product: ProductModel) {
        if products.contains(where: { $0.id == product.id }) {
            if let index = products.firstIndex(where: { $0.id == product.id }) {
                products[index].plus()
            }
        } else {
            var model = product
            model.plus()
            products.append(model)
        }
        
        print(products)
    }
    
    public func remove(product: ProductModel) {
        if products.contains(where: { $0.id == product.id }) {
            if let index = products.firstIndex(where: { $0.id == product.id }) {
                products[index].minus()
            }
        }
    }
    
    public func removeAll() {
        products = []
    }
}
