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
    
    open override var selectedIndex: Int {
        didSet {
            self.tabBarView?.setSelectedIndex(self.selectedIndex, animated: true)
        }
    }
    
    open func setupComponets() {
        self.view.backgroundColor = .yellow
        
        let tabBarView = TabBarView(itemsViews: [
            TabBarItemView(item: .init(title: "News", image: nil, tag: 0)),
            TabBarItemView(item: .init(title: "222", image: nil, tag: 1)),
            TabBarItemView(item: .init(title: "333", image: nil, tag: 2)),
            TabBarItemView(item: .init(title: "444", image: nil, tag: 3))
        ], selectedIndex: 0)
        
        self.viewControllers = tabBarView.itemsViews.map({ _ in
            let result = NewsListViewController(model: .init())
            
            return result
        })
        
        self.tabBarView = tabBarView
    }
    
    open func setTabBarView() {
        TabBarView.removeFromTabBarController(self)
        
        if let tabBarView = self.tabBarView {
            tabBarView.addToTabBarController(self)
            
            tabBarView.didSetSelectedIndex = { [weak self] selectedIndex in
                self?.selectedIndex = selectedIndex
            }
            
            self.tabBar.isHidden = true
            self.additionalSafeAreaInsets.bottom = 48
        } else {
            self.tabBar.isHidden = false
            self.additionalSafeAreaInsets.bottom = 0
        }
    }
}
