import DesignSystem
import UIKit

final class ProductTableViewCell: TableViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func configureCell(with model: ProductTableViewCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        priceLabel.text = model.price
    }
    
    private func setupCell() {
        contentView.addSubview(commonStackView)
        
        commonStackView.addArrangedSubviews([
            productImageView,
            bodyStackView
        ])
        
        bodyStackView.addArrangedSubviews([
            textStackView,
            infoStackView
        ])
        
        textStackView.addArrangedSubviews([
            titleLabel,
            subtitleLabel
        ])
        
        infoStackView.addArrangedSubviews([
            priceLabel,
            addButton
        ])
        
        NSLayoutConstraint.activate([
            commonStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commonStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func didTapAddButton() {
        print(#function)
    }
}
