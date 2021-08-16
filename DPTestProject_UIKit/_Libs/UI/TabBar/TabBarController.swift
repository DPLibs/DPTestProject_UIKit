//
//  TabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

public protocol TabBarControllerInput: AnyObject {
    var selectedIndex: Int { get set }
    var selectedItem: TabBarItem? { get set }
}
 
open class TabBarController: UITabBarController, TabBarControllerInput {
    
    // MARK: - Props
    open var items: [TabBarItem] = []
    
    open var tabBarView: TabBarView? {
        didSet {
            oldValue?.removeFromSuperview()
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
    
    open var selectedItem: TabBarItem? {
        get {
            self.items.first(where: { $0.tag == self.selectedIndex })
        }
        set {
            guard let tag = newValue?.tag, self.items.contains(where: { $0.tag == tag }) else { return }
            
            self.selectedIndex = tag
        }
    }
    
    open func setupComponets() { }
    
    open func setTabBarView() {
        if let tabBarView = self.tabBarView {
            tabBarView.addToTabBarController(self)
            tabBarView.setSelectedIndex(self.selectedIndex, animated: false)
            
            tabBarView.didSelectIndex = { [weak self] selectedIndex in
                self?.selectedIndex = selectedIndex
            }
            
            self.tabBar.isHidden = true
            self.additionalSafeAreaInsets.bottom = tabBarView.additionalSafeAreaInsetsBottom
        } else {
            self.tabBar.isHidden = false
            self.additionalSafeAreaInsets.bottom = .zero
        }
    }
}
