import DesignSystem
import UIKit

extension Auth.Screen.Phone {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            
            let button = setupButton(title: "Show Code Screen", target: self, selector: #selector(didTapButton))
            
            view.addStackView(button) //почесу не работает addSubView?
        }
        
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
    }
}

extension Auth.Screen.Phone.ViewController: Auth.Screen.Phone.DisplayLogic {}
