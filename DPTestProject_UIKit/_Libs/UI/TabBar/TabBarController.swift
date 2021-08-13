//
//  TabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

open class TabBarController: UITabBarController {
    
    // MARK: - Props
    open var tabBarView: TabBarView? {
        didSet {
            self.setTabBarView()
        }
    }
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        
        self.tabBarView?.setSelectedIndex(self.selectedIndex, animated: true)
    }
    
    open func setupComponets() {
        self.view.backgroundColor = .yellow
        
        self.tabBarView = .init(itemsViews: [
            .init(item: .init(title: "111", image: nil, tag: 0)),
            .init(item: .init(title: "222", image: nil, tag: 1)),
            .init(item: .init(title: "333", image: nil, tag: 2)),
            .init(item: .init(title: "444", image: nil, tag: 3))
        ])
        
        self.tabBarView?.backgroundColor = .gray
        self.tabBarView?.contentView.backgroundColor = .darkGray
        
        self.viewControllers = self.tabBarView?.itemsViews.map({
            let result = UIViewController()
            result.tabBarItem = $0.item ?? .init()
            
            return result
        })
    }
    
    open func setTabBarView() {
        TabBarView.removeFromTabBarController(self)
        
        if let tabBarView = self.tabBarView {
            tabBarView.addToTabBarController(self)
            
            tabBarView.didSetSelectedIndex = { [weak self] selectedIndex in
                self?.selectedIndex = selectedIndex
            }
            
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}
