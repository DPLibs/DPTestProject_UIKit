//
//  ViewRouter.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation
import UIKit

open class ViewRouter {
    
    weak var _viewController: UIViewController?
    
    open func setupRootController(_ viewController: UIViewController) {
        let window = self._viewController?.view.window
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self._viewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
}

extension ViewRouter {
    
    func showMain() {
        let vc = MainViewController(model: .init())
        let nav = UINavigationController(rootViewController: vc)
        
        self.setupRootController(nav)
    }
    
}
