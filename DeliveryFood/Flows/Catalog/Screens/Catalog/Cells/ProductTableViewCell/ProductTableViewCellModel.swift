struct ProductTableViewCellModel {
    let title: String
    let subtitle: String
    let price: String
    let imageString: String
    let count: Int
}

struct ProductModel {
    let id: String
    let title: String
    let subtitle: String
    let price: Int
    let currency: CurrencyType
    var count: Int
}

struct ProductResponse: Decodable {
    let id: String
    let title: String
    let subtitle: String
    let price: String
    let currency: Int
}

enum CurrencyType: Int {
    case rub = 0
    
    var title: String {
        switch self {
        case .rub:
            return "руб"
        }
    }
}

