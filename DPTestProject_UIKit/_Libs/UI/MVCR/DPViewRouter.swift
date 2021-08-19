import Foundation
import UIKit

open class DPViewRouter {
    
    // MARK: - Props
    open weak var _viewController: UIViewController?
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Methods
    open func setupRootController(_ viewController: UIViewController) {
        let window = self._viewController?.view.window
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self._viewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    open func push(viewController: UIViewController, animated: Bool) {
        self._viewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    open func popViewController(animated: Bool) -> UIViewController? {
        self._viewController?.navigationController?.popViewController(animated: animated)
    }

    @discardableResult
    open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        self._viewController?.navigationController?.popToViewController(viewController, animated: animated)
    }

    @discardableResult
    open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        self._viewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
}
