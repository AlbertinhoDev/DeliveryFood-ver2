import DesignSystem
import UIKit

extension Catalog.Screen.Product {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            let button = setupButton(title: "Show Map", target: self, selector: #selector(didTapButton))
            view.addStackView(button)
        }
        
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
    }
}

extension Catalog.Screen.Product.ViewController: Catalog.Screen.Product.DisplayLogic {}
