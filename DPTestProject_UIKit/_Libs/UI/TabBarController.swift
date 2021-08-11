//
//  TabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    lazy var buttons: [UIButton] = {
        self.items.map({
            let result = UIButton()
            result.setTitle($0.title, for: .normal)
            result.tag = $0.tag
            result.addTarget(self, action: #selector(self.tapButton(_:)), for: .touchUpInside)
            result.backgroundColor = $0.tag == self.selectedIndex ? .darkGray : .clear
            
            return result
        })
    }()
    
    lazy var customTabBar: UIView = {
        let result = UIView()
        result.backgroundColor = .red
        
        let stackView = UIStackView(arrangedSubviews: self.buttons)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        stackView.removeFromSuperview()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        result.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: result.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: result.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: result.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: result.trailingAnchor)
        ])
        
        return result
    }()
    
    @objc
    private func tapButton(_ button: UIButton) {
        self.selectedIndex = button.tag
        
        self.buttons.forEach({
            $0.backgroundColor = $0.tag == self.selectedIndex ? .darkGray : .clear
        })
    }
    
    var items: [UITabBarItem] {
        [
            .init(title: "111", image: nil, tag: 0),
            .init(title: "222", image: nil, tag: 1),
            .init(title: "333", image: nil, tag: 2),
            .init(title: "444", image: nil, tag: 3)
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    func setupViews() {
        self.viewControllers = self.items.enumerated().map({ index, item in
            let result = UIViewController()
            result.tabBarItem = item
            
            switch index {
            case 0:
                result.view.backgroundColor = .blue
            case 1:
                result.view.backgroundColor = .brown
            case 2:
                result.view.backgroundColor = .green
            default:
                result.view.backgroundColor = .gray
            }
            
            let nav = UINavigationController(rootViewController: result)
            return nav
        })
        
        self.view.backgroundColor = .yellow
        self.tabBar.isHidden = true
        
        self.customTabBar.removeFromSuperview()
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.customTabBar)
        
        NSLayoutConstraint.activate([
            self.customTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            self.customTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.customTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.customTabBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
