import DesignSystem
import UIKit

extension Map.Screen.Map {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            
            let button = setupButton(title: "Show Catalog", target: self, selector: #selector(didTapButton))
            
            view.addStackView(button)
        }
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
    }
}

extension Map.Screen.Map.ViewController: Map.Screen.Map.DisplayLogic {}
