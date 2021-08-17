//
//  NavigationController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

open class NavigationBarView: UIView {
    
    
    
}

open class NavigationController: UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open func setupComponets() {
        self.setNavigationBarHidden(true, animated: false)
        
        let navi = NavigationBarView()
        navi.backgroundColor = .red
        navi.removeFromSuperview()
        navi.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navi)
        
        NSLayoutConstraint.activate([
            navi.topAnchor.constraint(equalTo: self.view.topAnchor),
            navi.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navi.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navi.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        self.additionalSafeAreaInsets.top = 100
    }
    
}
