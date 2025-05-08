import Core

struct ProductTableViewCellModel {
    let title: String
    let subtitle: String
    let price: String
    let imageString: String
    let count: Int
    var plusAction: () -> Void
    var minusAction: () -> Void
}

extension ProductTableViewCellModel {
    init(
        model: ProductModel,
        plusAction: @escaping () -> Void,
        minusAction: @escaping () -> Void
    ) {
        title = model.title
        subtitle = model.subtitle
        price = "\(model.price) \(model.currency.title)"
        imageString = ""
        count = model.count
        self.plusAction = plusAction
        self.minusAction = minusAction
    }
}

struct ProductResponse: Decodable {
    let id: String
    let title: String
    let subtitle: String
    let price: String
    let currency: Int
}
