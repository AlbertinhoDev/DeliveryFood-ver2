import Core
import Foundation

extension Catalog.Screen.Catalog {
    final class Presenter {
        weak var viewController: DisplayLogic?
        var router: RoutingLogic?
        
        private var products: [ProductModel] = []
        private let cartManager: CartManagable
        
        init(cartManager: CartManagable) {
            self.cartManager = cartManager
        }
        
        private func fetchProduct() async throws -> [ProductModel] {
            try await Task.sleep(for: .seconds(0.5))
            return [
                ProductModel(id: UUID().uuidString, title: "Title 1", subtitle: "Subtitle 1", price: 100, currency: .rub, count: 0),
                ProductModel(id: UUID().uuidString, title: "Title 2", subtitle: "Subtitle 2", price: 200, currency: .rub, count: 0)
            ]
        }
        
        private func makePromotionSection() -> Catalog.Screen.Catalog.Section {
            return Section(type: .promotions, rows: [.promotions])
        }
        
        private func makeCategoriesSection() -> Catalog.Screen.Catalog.Section {
            return Section(type: .categories, rows: [.categories])
        }
        
        private func makeProductsSection() -> Catalog.Screen.Catalog.Section {
            let rows = products.compactMap { product in
                let plusAction = { [weak self] in
                    guard let self else { return }
                    cartManager.add(product: product)
                    let index = products.firstIndex(where: { prod in
                        prod.id == product.id
                    })!
                    products[index].count += 1
                    
                    viewController?.update(sections: makeSections())
                }
                let minusAction = { [weak self] in
                    guard let self else { return }
                    cartManager.remove(product: product)

                    let index = products.firstIndex(where: { prod in
                        prod.id == product.id
                    })!
                    products[index].count -= 1

                    viewController?.update(sections: makeSections())
                }
                let viewModel = ProductTableViewCellModel(model: product, plusAction: plusAction, minusAction: minusAction)
                return Catalog.Screen.Catalog.RowType.product(viewModel)
            }
            return Section(type: .products, rows: rows)
        }
        
        private func makeSections() -> [Catalog.Screen.Catalog.Section] {
            return [
                makePromotionSection(),
                makeCategoriesSection(),
                makeProductsSection()
            ]
        }
    }
}

extension Catalog.Screen.Catalog.Presenter: Catalog.Screen.Catalog.PresentationLogic {
    func viewDidLoad() {
        Task {
            do {
                products = try await fetchProduct()
                let sections = makeSections()
                await MainActor.run {
                    viewController?.update(sections: sections)
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func didTapButton() {
        router?.showMapScreen()
    }
    
    func didTapProduct(index: Int) {
        let product = products[index]
        router?.showProductScreen(product: product)
    }
    
    func didTapBackButton() {
        router?.back()
    }
}
//
//extension Catalog.Screen.Catalog.Presenter: ProductTableViewCellDelegate {
//    func didAddTapButton() {
//        print(#function)
//    }
//}
