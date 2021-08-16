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
    open var didSelectIndex: ((Int) -> Void)?
    
    open private(set) var itemsViews: [TabBarItemView] = []
    
    public lazy var stackView: UIStackView = {
        let result = UIStackView()
        result.axis = .horizontal
        result.distribution = .fillEqually
        result.spacing = 4
        
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
    
    open var stackHeightConstant: CGFloat = 48 {
        didSet {
            self.setStackView()
        }
    }
    
    open var stackInsets: NSDirectionalEdgeInsets = .init(
        top: 8,
        leading: 8,
        bottom: -(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0),
        trailing: -8
    ) {
        didSet {
            self.setStackView()
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
    
    convenience init(items: [TabBarItem]) {
        self.init(frame: .zero)
        
        self.setItemsViews(from: items)
    }
    
    // MARK: - Methods
    open var additionalSafeAreaInsetsBottom: CGFloat {
        self.stackHeightConstant
    }
    
    open func setupViews() {
        self.backgroundColor = .lightGray
        
        self.setSelf()
        self.setStackView()
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
    
    open func setStackView() {
        self.stackView.removeFromSuperview()
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.stackInsets.top),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.stackInsets.bottom),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.stackInsets.leading),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.stackInsets.trailing),
            self.stackView.heightAnchor.constraint(equalToConstant: self.stackHeightConstant)
        ])
    }
    
    open func addToTabBarController(_ tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    open func setItemsViews(from items: [TabBarItem]) {
        self.stackView.subviews.forEach({ $0.removeFromSuperview() })
        
        self.itemsViews = items.map({ TabBarItemView(item: $0) })
        
        self.itemsViews.forEach({ itemView in
            itemView.didSelected = { [weak self] in
                self?.didSelectIndex?(itemView.item.tag)
            }
            
            self.stackView.addArrangedSubview(itemView)
        })
    }
    
    open func setSelectedIndex(_ selectedIndex: Int, animated: Bool) {
        self.itemsViews.forEach({ itemView in
            itemView.setSelected(itemView.item.tag == selectedIndex, animated: animated)
        })
    }
}


