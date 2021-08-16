//
//  TabBarView.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 12.08.2021.
//

import Foundation
import UIKit

open class TabBarView: UIView {
    
    // MARK: - Props
    open var didSetSelectedIndex: ((Int) -> Void)?
    
    open var items: [UITabBarItem] = [] {
        didSet {
            self.updateViews()
        }
    }
    
    open private(set) var itemsViews: [TabBarItemViewInput] = []
    
    public lazy var contentView: UIView = {
        let result = UIView()
        
        return result
    }()
    
    public lazy var stackContentView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        
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
        top: 4,
        leading: 8,
        bottom: -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0),
        trailing: -8
    ) {
        didSet {
            self.setContentView()
        }
    }
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    convenience init(items: [UITabBarItem]) {
        self.init(frame: .zero)
        
        self.items = items
        self.updateViews()
    }
    
    // MARK: - Methods
    open func setupViews() {
        self.backgroundColor = .lightGray
        
        self.setSelf()
        self.setContentView()
        self.setStackContentView()
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
    
    open func setStackContentView() {
        self.stackContentView.removeFromSuperview()
        self.stackContentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackContentView)
        
        NSLayoutConstraint.activate([
            self.stackContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.stackContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.stackContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
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
    
    open func updateViews() {
        self.stackContentView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.itemsViews = self.items.map({ TabBarItemView(item: $0) })
        
        self.itemsViews.forEach({ itemView in
            itemView.didSelected = { [weak self] in
                self?.didSetSelectedIndex?(itemView.item.tag)
            }
            
            self.stackContentView.addArrangedSubview(itemView)
        })
    }
    
    open func setSelectedIndex(_ selectedIndex: Int, animated: Bool) {
        self.itemsViews.forEach({ itemView in
            itemView.setSelected(itemView.item.tag == selectedIndex, animated: animated)
        })
    }
}


