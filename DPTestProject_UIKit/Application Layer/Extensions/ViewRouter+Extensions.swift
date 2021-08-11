//
//  ViewRouter+Extensions.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

extension ViewRouter {
    
    func showMain() {
//        let vc = MainViewController(model: .init())
//        let nav = UINavigationController(rootViewController: vc)
        
        let vc = TabBarController()
        
        self.setupRootController(vc)
    }
    
}
