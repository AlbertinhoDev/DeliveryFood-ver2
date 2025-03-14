import DesignSystem
import UIKit

final class ProductTableViewCell: TableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func configureCell(with model: ProductTableViewCellModel) {
    }
    
    private func setupCell() {
        backgroundColor = .red
    }
}
