import DesignSystem
import UIKit

final class CategoriesTableViewCell: TableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    private func setupCell() {
        backgroundColor = .orange
    }
}
