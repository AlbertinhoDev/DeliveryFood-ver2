import DesignSystem
import UIKit

extension Profile.Screen.Profile {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
         
            let button = setupButton(title: "Logout", target: self, selector: #selector(didTapButton))
            
            view.addStackView(button)
            
            presenter?.viewDidLoad()
        }
        
        @objc private func didTapButton() {
            presenter?.didTapLogoutButton()
        }
    }
}

extension Profile.Screen.Profile.ViewController: Profile.Screen.Profile.DisplayLogic {
    
}
