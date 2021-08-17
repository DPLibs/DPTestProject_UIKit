//
//  ViewRouter+Extensions.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

extension ViewRouter {
    
    @discardableResult
    func showMain() -> MainTabBarControllerInput {
        let vc = MainTabBarController()
        self.setupRootController(vc)
        
        return vc
    }
    
    @discardableResult
    func showNewsDetail(model: NewsDetailViewModel) -> NewsDetailViewControllerInput {
        let vc = NewsDetailViewController(model: model)
        self.push(viewController: vc, animated: true)
        
        return vc
    }
}
