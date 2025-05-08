extension Catalog.Screen.Catalog {
    protocol PresentationLogic {
        func viewDidLoad()
        func didTapButton()
        func didTapProduct(index: Int)
        func didTapBackButton()
    }
}
