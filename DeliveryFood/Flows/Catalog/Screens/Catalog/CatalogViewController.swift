import DesignSystem
import UIKit

extension Catalog.Screen.Catalog {
    final class ViewController: UIViewController {
        var presenter: PresentationLogic?
        
        private let navigationBar = NavigationBar()
        
        private var sections: [Section] = []
        
        private let tableView = TableView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .gray
            
            setupViewController()
            presenter?.viewDidLoad()
        }
        
        private func setupViewController() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            
            tableView.dataSource = self
            tableView.delegate = self

            tableView.register(PromotionsTableViewCell.self)
            tableView.register(CategoriesTableViewCell.self)
            tableView.register(ProductTableViewCell.self)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}

extension Catalog.Screen.Catalog.ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let rowType = sections[section].rows[row]
        
        switch rowType {
        case .promotions:
            let cell = tableView.dequeueReusableCell(PromotionsTableViewCell.self, indexPath: indexPath)
            return cell
        case .categories:
            let cell = tableView.dequeueReusableCell(CategoriesTableViewCell.self, indexPath: indexPath)
            return cell
        case .product:
            let cell = tableView.dequeueReusableCell(ProductTableViewCell.self, indexPath: indexPath)
            return cell
        }
    }
}
extension Catalog.Screen.Catalog.ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        let rowType = sections[section].rows[row]
        
        print(indexPath, rowType, row + 1)
    }
}

extension Catalog.Screen.Catalog.ViewController: Catalog.Screen.Catalog.DisplayLogic {
    func update(sections: [Catalog.Screen.Catalog.Section]) {
        self.sections = sections
        tableView.reloadData()
    }
}

extension Catalog.Screen.Catalog.ViewController: NavigationBarDelegate {
    func didTapBackButton() {
        presenter?.didTapBackButton()
    }
}
