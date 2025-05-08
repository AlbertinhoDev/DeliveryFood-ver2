import UIKit

public protocol NavigationBarDelegate: AnyObject {
    func didTapBackButton()
}

public final class NavigationBar: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
//    private lazy var backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "house"), for: .normal)
//        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//        return button
//    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private weak var delegate: NavigationBarDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public func configure(title: String, delegate: NavigationBarDelegate?) {
        titleLabel.text = title
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
//        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }
}
