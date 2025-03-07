import DesignSystem
import UIKit

extension Auth.Screen.Code {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            
            let button = setupButton(title: "Show Profile Screen", target: self, selector: #selector(didTapButton))
            
            view.addStackView(button)
        }
        
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.isTabBarHidden = true
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            tabBarController?.isTabBarHidden = false
        }
    }
}

extension Auth.Screen.Code.ViewController: Auth.Screen.Code.DisplayLogic {}
