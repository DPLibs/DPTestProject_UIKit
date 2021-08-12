//
//  TabBarController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 11.08.2021.
//

import Foundation
import UIKit

open class TabBarItemView: UIView {
    
    open var item: UITabBarItem?
    
    open var didSetSelected: ((Bool) -> Void)?
    
    open func setSelected(_ isSelected: Bool, animated: Bool) {}

}

open class TabBarView: UIView {
    
    open var didSetSelectedIndex: ((Int) -> Void)?
    
    open var itemsViews: [TabBarItemView] = [] {
        didSet {
            self.itemsViews.enumerated().forEach({ index, itemView in
                itemView.didSetSelected = { [weak self] isSelected in
                    if isSelected {
                        self?.didSetSelectedIndex?(index)
                    }
                }
            })
        }
    }
    
    open func setSelectedIndex(_ selectedIndex: Int, animated: Bool) {
        guard self.itemsViews.indices.contains(selectedIndex) else { return }
        
        self.itemsViews[selectedIndex].setSelected(true, animated: animated)
    }
    
    open lazy var contentView: UIView = {
        let result = UIView()
        
        return result
    }()
    
    private weak var tabBarController: UITabBarController? {
        didSet {
            self.setSelf()
        }
    }
    
    open var leadingConstant: CGFloat = .zero {
        didSet {
            self.setSelf()
        }
    }
    
    open var trailingConstant: CGFloat = .zero {
        didSet {
            self.setSelf()
        }
    }
    
    open var bottomConstant: CGFloat = .zero {
        didSet {
            self.setSelf()
        }
    }
    
    open var contentHeightConstant: CGFloat = 48 {
        didSet {
            self.setContentView()
        }
    }
    
    open var contentInsets: NSDirectionalEdgeInsets = .init(
        top: 0,
        leading: 0,
        bottom: -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0),
        trailing: 0
    ) {
        didSet {
            self.setContentView()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    open func setupViews() {
        self.setSelf()
        self.setContentView()
    }
    
    open func setSelf() {
        self.removeFromSuperview()
        
        guard let superview = self.tabBarController?.view else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: self.leadingConstant),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: self.trailingConstant),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: self.bottomConstant)
        ])
    }
    
    open func setContentView() {
        self.contentView.removeFromSuperview()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentView)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.contentInsets.top),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.contentInsets.bottom),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.contentInsets.leading),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.contentInsets.trailing),
            self.contentView.heightAnchor.constraint(equalToConstant: self.contentHeightConstant)
        ])
    }
    
    open func addToTabBarController(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    open class func removeFromTabBarController(_ tabBarController: UITabBarController) {
        tabBarController.view.subviews.forEach({ subview in
            guard subview is TabBarView else { return }
            
            subview.removeFromSuperview()
        })
    }
}

open class TabBarController: UITabBarController {
    
    open var tabBarView: TabBarView? {
        didSet {
            self.setTabBarView()
        }
    }
    
    var items: [UITabBarItem] {
        [
            .init(title: "111", image: nil, tag: 0),
            .init(title: "222", image: nil, tag: 1),
            .init(title: "333", image: nil, tag: 2),
            .init(title: "444", image: nil, tag: 3)
        ]
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    func setupViews() {
        var itemsViews: [TabBarItemView] = []
        
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
            
            let itemView = CustomTabBarView.ItemView()
            itemView.item = item
            itemsViews += [itemView]
            
            let nav = UINavigationController(rootViewController: result)
            return nav
        })
        
        self.view.backgroundColor = .yellow
        
        self.tabBarView = CustomTabBarView()
        self.tabBarView?.backgroundColor = .red
        self.tabBarView?.contentView.backgroundColor = .darkGray
        self.tabBarView?.itemsViews = itemsViews
    }
    
    open func setTabBarView() {
        TabBarView.removeFromTabBarController(self)
        
        self.tabBarView?.addToTabBarController(self)
        self.tabBarView?.didSetSelectedIndex = { [weak self] selectedIndex in
            self?.selectedIndex = selectedIndex
        }
        
        self.tabBar.isHidden = self.tabBarView != nil
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        
        self.tabBarView?.setSelectedIndex(self.selectedIndex, animated: true)
    }
}

class CustomTabBarView: TabBarView {
    
    class ItemView: TabBarItemView {
        
        override var item: UITabBarItem? {
            didSet {
                self.button.setTitle(self.item?.title ?? "q", for: .normal)
            }
        }
        
        lazy var button: UIButton = {
            let result = UIButton()
            result.setTitleColor(.black, for: .normal)
            result.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
            result.setTitle(self.item?.title ?? "q", for: .normal)
            
            return result
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupViews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            self.setupViews()
        }
        
        func setupViews() {
            self.button.removeFromSuperview()
            self.button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.button)
            
            NSLayoutConstraint.activate([
                self.button.topAnchor.constraint(equalTo: self.topAnchor),
                self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        }
        
        @objc
        private func tapButton() {
            self.setSelected(true, animated: true)
            self.didSetSelected?(true)
        }
        
        override func setSelected(_ isSelected: Bool, animated: Bool) {
            self.backgroundColor = isSelected ? .blue : .clear
        }
        
    }
    
    lazy var stackView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        
        return result
    }()
    
    override var itemsViews: [TabBarItemView] {
        didSet {
            self.stackView.subviews.forEach({ $0.removeFromSuperview() })
            self.itemsViews.forEach({
                self.stackView.addArrangedSubview($0)
            })
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.stackView.removeFromSuperview()
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
}
