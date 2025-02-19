import DesignSystem
import UIKit

extension Map.Screen.Map {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            
            let button = setupButton(title: "Show Catalog", target: self, selector: #selector(didTapButton))
            let button1 = setupButton(title: "Login", target: self, selector: #selector(didTapButton1))
            let button2 = setupButton(title: "Get User", target: self, selector: #selector(didTapButton2))
            let button3 = setupButton(title: "Refresh Token", target: self, selector: #selector(didTapButton3))
            
            view.addStackView(button, button1, button2, button3)
        }
        @objc private func didTapButton() {
            presenter?.didTapButton()
        }
        
        @objc private func didTapButton1() {
            presenter?.didTapButton1()
        }
        
        @objc private func didTapButton2() {
            presenter?.didTapButton2()
        }
        
        @objc private func didTapButton3() {
            presenter?.didTapButton3()
        }
    }
}

extension Map.Screen.Map.ViewController: Map.Screen.Map.DisplayLogic {}
