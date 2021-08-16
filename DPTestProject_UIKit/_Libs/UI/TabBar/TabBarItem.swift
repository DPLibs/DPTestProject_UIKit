//
//  TabBarItem.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

open class TabBarItem: UITabBarItem {
    
    open override var badgeValue: String? {
        didSet {
            self.didSetBadgeValue?(self.badgeValue)
        }
    }
    
    open var didSetBadgeValue: ((String?) -> Void)?
    
}
