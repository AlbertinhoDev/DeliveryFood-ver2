import DesignSystem
import UIKit

extension Catalog.Screen.Product {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        private let navigationBar = NavigationBar()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            let button1 = setupButton(title: "Show Map", target: self, selector: #selector(didTapButton))
            let button2 = setupButton(title: "Show Promotion", target: self, selector: #selector(didTapProductButton))
            view.addStackView(button1, button2)
            
            setupViewController()
        }
        
        private func setupViewController() {
            navigationBar.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(navigationBar)
            
            
            NSLayoutConstraint.activate([
                navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
            
            navigationBar.configure(title: "Title123", delegate: self)
        }
        
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
        
        @objc private func didTapProductButton() {
            presenter?.didTapPromotion()
        }
    }
}

extension Catalog.Screen.Product.ViewController: Catalog.Screen.Product.DisplayLogic {}

extension Catalog.Screen.Product.ViewController: NavigationBarDelegate {
    func didTapBackButton() {
        presenter?.didTapBackButton()
    }
}
