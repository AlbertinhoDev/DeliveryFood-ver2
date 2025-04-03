import DesignSystem
import UIKit

final class PromotionsCollectionViewCell: CollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func configure(model: PromotionsCollectionViewCellModel) {}
    
    private func setupCell() {
        backgroundColor = .brown
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}

final class PromotionsTableViewCell: TableViewCell {
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(PromotionsCollectionViewCell.self, forCellWithReuseIdentifier: "PromotionsCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var promotions: [PromotionsCollectionViewCellModel] = Array(repeating: PromotionsCollectionViewCellModel(), count: 5)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    func configureCell(model: PromotionsTableViewCellModel) {
        promotions = model.promotions
        collectionView.reloadData()
    }
    
    private func setupCell() {
        backgroundColor = .yellow
        contentView.addLayoutSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.heightAnchor.constraint(equalToConstant: 106)
        ])
    }
}

extension PromotionsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionsCollectionViewCell", for: indexPath) as? PromotionsCollectionViewCell else {
            fatalError()
        }
        let model = promotions[indexPath.item]
        cell.configure(model: model)
        return cell
    }
}

extension PromotionsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension PromotionsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.75
        return CGSize(width: width, height: 106)
    }
}
