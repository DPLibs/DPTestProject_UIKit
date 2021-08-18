//
//  NavigationController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

open class BarButtonItemView: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var widthConstraint: NSLayoutConstraint = {
        let result = self.widthAnchor.constraint(equalToConstant: self.size.width)
        result.isActive = true
        
        return result
    }()
    
    lazy var heightConstraint: NSLayoutConstraint = {
        let result = self.heightAnchor.constraint(equalToConstant: self.size.height)
        result.isActive = true
        
        return result
    }()
    
    open var handler: (() -> Void)?
    
    open var size: CGSize = .init(width: 24, height: 24) {
        didSet {
            self.setupViews()
        }
    }
    
    init(handler: (() -> Void)?) {
        super.init(frame: .zero)
        
        self.handler = handler
        self.setupViews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }

    open func setupViews() {
        self.widthConstraint.constant = self.size.width
        self.heightConstraint.constant = self.size.height
        
        self.button.removeFromSuperview()
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.button)
        
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.button.topAnchor.constraint(equalTo: self.topAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc
    open func tapButton() {
        self.handler?()
    }
    
}

open class NavigationBarView: UIView {
    
    open var leftBarButtonItemView: BarButtonItemView? {
        didSet {
            oldValue?.removeFromSuperview()
            self.setLeftBarButtonItemView()
        }
    }
    
    lazy var leftContentView: UIView = {
        let result = UIView()
        
        return result
    }()
    
    lazy var middleContentView: UIView = {
        let result = UIView()
        result.backgroundColor = .darkGray
        
        return result
    }()
    
    lazy var rightContentView: UIView = {
        let result = UIView()
        result.backgroundColor = .green
        
        return result
    }()
    
    lazy var leftContentWidthConstraint: NSLayoutConstraint = {
        let result = self.leftContentView.widthAnchor.constraint(equalToConstant: 24)
        result.isActive = true
        
        return result
    }()
    
    lazy var rightContentWidthConstraint: NSLayoutConstraint = {
        let result = self.rightContentView.widthAnchor.constraint(equalToConstant: 24)
        result.isActive = true
        
        return result
    }()
    
    lazy var stackView: UIStackView = {
        let result = UIStackView(arrangedSubviews: [
            self.leftContentView,
            self.middleContentView,
            self.rightContentView
        ])
        
        result.axis = .horizontal
        result.backgroundColor = .red
        result.spacing = 8
        
        return result
    }()
    
    open var stackInsets: NSDirectionalEdgeInsets = .init(
        top: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0,
        leading: 8,
        bottom: -8,
        trailing: -8
    ) {
        didSet {
            self.setupViews()
        }
    }
    
    open var stackHeight: CGFloat = 40 {
        didSet {
            self.setupViews()
        }
    }
    
    // MARK: - Init
    init(leftView: BarButtonItemView?) {
        super.init(frame: .zero)
        
        self.leftBarButtonItemView = leftView
        self.setupViews()
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
        self.backgroundColor = .lightGray
        
        self.setStackView()
        self.setLeftBarButtonItemView()
        
        self.leftContentWidthConstraint.constant = 24
        self.rightContentWidthConstraint.constant = 24
    }
    
    open func addToNavigationController(_ navigationController: NavigationController) {
        self.setSelf(in: navigationController)
        
        navigationController.additionalSafeAreaInsets.top = self.stackHeight
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    open func removeFromNavigationController(_ navigationController: NavigationController) {
        self.setSelf(in: nil)
        
        navigationController.additionalSafeAreaInsets.top = .zero
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    open func setSelf(in navigationController: NavigationController?) {
        self.removeFromSuperview()
        
        guard let superview = navigationController?.view else { return }
        self.backgroundColor = .lightGray
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
    }
    
    open func setStackView() {
        self.stackView.removeFromSuperview()
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: self.stackInsets.top),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.stackInsets.leading),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: self.stackInsets.trailing),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: self.stackInsets.bottom),
            self.stackView.heightAnchor.constraint(equalToConstant: self.stackHeight)
        ])
    }
    
    open func setLeftBarButtonItemView() {
        self.leftBarButtonItemView?.removeFromSuperview()
        
        guard let view = self.leftBarButtonItemView else { return }
        view.removeFromSuperview()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.leftContentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: self.leftContentView.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: self.leftContentView.centerXAnchor)
        ])
    }
    
}

open class NavigationController: UINavigationController {
    
    open var navigationBarView: NavigationBarView? {
        didSet {
            oldValue?.removeFromNavigationController(self)
            self.navigationBarView?.addToNavigationController(self)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open func setupComponets() {
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        self.navigationBarView = nil
    }
    
    @discardableResult
    open override func popViewController(animated: Bool) -> UIViewController? {
        let result = super.popViewController(animated: animated)
        
        if result != nil {
            self.navigationBarView = nil
        }
        
        return result
    }
    
    @discardableResult
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let result = super.popToRootViewController(animated: animated)
        
        if result != nil {
            self.navigationBarView = nil
        }
        
        return result
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        
        self.navigationBarView = nil
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension NavigationController: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}

public extension UIViewController {
    
    var dpNavigationController: NavigationController? {
        self.navigationController as? NavigationController
    }
    
}
