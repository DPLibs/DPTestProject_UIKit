//
//  MainTabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

extension DPTabBarItem {
    static let news: DPTabBarItem = .init(title: "News", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 0)
    static let test1: DPTabBarItem = .init(title: "test1", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 1)
    static let test2: DPTabBarItem = .init(title: "test2", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 2)
    static let settings: DPTabBarItem = .init(title: "Settings", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 3)
}

protocol MainTabBarControllerInput: DPTabBarControllerInput {}

class MainTabBarController: DPTabBarController, MainTabBarControllerInput {
    
    override func setupComponets() {
        self.items = [.news, .test1, .test2, .settings]
        
        self.viewControllers = self.items.map({ item in
            var rootViewController: UIViewController
            
            switch item {
            case .news:
                rootViewController = NewsListViewController(model: .init())
            case .settings:
                rootViewController = SettingViewController(model: .init())
            default:
                rootViewController = .init()
            }
            
            return DPNavigationController(rootViewController: rootViewController)
        })
    }
    
}

extension UIViewController {
    
    var mainTabBarControllerInput: MainTabBarControllerInput? {
        self.tabBarController as? MainTabBarControllerInput
    }
    
}
