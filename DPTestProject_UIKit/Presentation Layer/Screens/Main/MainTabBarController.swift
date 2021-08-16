//
//  MainTabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

extension TabBarItem {
    static let news: TabBarItem = .init(title: "News", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 0)
    static let test1: TabBarItem = .init(title: "test1", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 1)
    static let test2: TabBarItem = .init(title: "test2", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 2)
    static let settings: TabBarItem = .init(title: "Settings", image: #imageLiteral(resourceName: "ic_24").withRenderingMode(.alwaysTemplate), tag: 3)
}

protocol MainTabBarControllerInput: TabBarControllerInput {}

class MainTabBarController: TabBarController, MainTabBarControllerInput {
    
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
            
            return UINavigationController(rootViewController: rootViewController)
        })
        
        self.tabBarView = .init(items: self.items)
    }
    
}
