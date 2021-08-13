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
    
    open var itemsViews: [ItemView] = [] {
        didSet {
            self.didSetItemsViews()
        }
    }
    
    func didSetItemsViews() {
        self.stackContentView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.itemsViews.forEach({ itemView in
            itemView.didSetSelected = { [weak self] isSelected in
                if isSelected {
                    self?.didSetSelectedIndex?(itemView.item?.tag ?? 0)
                }
            }
            
            self.stackContentView.addArrangedSubview(itemView)
        })
    }
    
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
        top: 0,
        leading: 0,
        bottom: -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0),
        trailing: 0
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
    
    convenience init(itemsViews: [ItemView]) {
        self.init(frame: .zero)
        
        self.itemsViews = itemsViews
        self.didSetItemsViews()
    }
    
    // MARK: - Methods
    open func setupViews() {
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
    
    open func setSelectedIndex(_ selectedIndex: Int, animated: Bool) {
        self.itemsViews.forEach({ itemView in
            itemView.setSelected(itemView.item?.tag == selectedIndex, animated: animated)
        })
    }
}

// MARK: - ItemView
extension TabBarView {
    
    open class ItemView: UIView {
        
        // MARK: - Props
        open var item: UITabBarItem? {
            didSet {
                self.didSetItem()
            }
        }
        
        open var didSetSelected: ((Bool) -> Void)?
        
        lazy var button: UIButton = {
            let result = UIButton()
            result.addTarget(self, action: #selector(self.tapButton(_:)), for: .touchUpInside)
            
            return result
        }()
        
        // MARK: - Init
        convenience init(item: UITabBarItem) {
            self.init(frame: .zero)
            
            self.item = item
            self.didSetItem()
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupViews()
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            self.setupViews()
        }
        
        // MARK: - Methods
        open func setupViews() {
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
        
        open func setSelected(_ isSelected: Bool, animated: Bool) {
            print("!!!", self.item?.tag, isSelected)
            self.backgroundColor = isSelected ? .blue : .clear
            self.didSetSelected?(isSelected)
        }
        
        @objc
        open func tapButton(_ button: UIButton) {
            guard button == self.button else { return }
            
            self.setSelected(true, animated: true)
        }
        
        func didSetItem() {
            self.button.setTitle(self.item?.title, for: .normal)
        }

    }
    
}
