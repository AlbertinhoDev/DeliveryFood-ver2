extension Catalog.Screen.Catalog {
    enum SectionType {
        case promotions
        case categories
        case products
    }

    enum RowType {
        case promotions
        case categories
        case product(ProductTableViewCellModel)
    }

    struct Section {
        let type: SectionType
        let rows: [RowType]
    }
}
