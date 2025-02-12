import UIKit

extension UIView {
    public func addStackView(_ views: UIView...) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        views.forEach {
            stackView.addArrangedSubview($0)
        }
    }
}

public func setupButton(title: String, target: Any?, selector: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.addTarget(target, action: selector, for: .touchUpInside)
    return button
}
