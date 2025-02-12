import UIKit

public protocol Router {
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func setRoot(viewController: UIViewController, animated: Bool)
}
