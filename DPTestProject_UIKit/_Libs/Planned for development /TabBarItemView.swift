//
//  TabBarItemView.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation
import UIKit

open class TabBarItemView: UIControl {
    
    // MARK: - Props
    open var item: TabBarItem = .init() {
        didSet {
            self.updateViews()
        }
    }
    
    open var didSelected: (() -> Void)?
    
    public lazy var control: Control = {
        let result = Control()
        result.addTarget(self, action: #selector(self.provideDidSelected), for: .touchUpInside)
        
        return result
    }()
    
    public lazy var badgeView: BadgeView = {
        let result = BadgeView()
        
        return result
    }()
    
    // MARK: - Init
    convenience init(item: TabBarItem) {
        self.init(frame: .zero)
        
        self.item = item
        self.updateViews()
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
        [self.control, self.badgeView].forEach({
            $0.removeFromSuperview()
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        })
        
        NSLayoutConstraint.activate([
            self.control.topAnchor.constraint(equalTo: self.topAnchor),
            self.control.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.control.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.control.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.badgeView.topAnchor.constraint(equalTo: self.topAnchor),
            self.badgeView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    open func updateViews() {
        self.item.didSetBadgeValue = { [weak self] badgeValue in
            self?.updateBadgeValue(badgeValue)
        }
        
        self.control.imageView.image = self.item.image
        self.control.titleLabel.text = self.item.title
        
        self.updateBadgeValue(self.item.badgeValue)
    }
    
    open func updateBadgeValue(_ badgeValue: String?) {
        self.badgeView.isHidden = badgeValue == nil
        self.badgeView.titleLabel.text = badgeValue
    }
    
    open func setSelected(_ isSelected: Bool, animated: Bool) {
        if let selectedImage = self.item.selectedImage {
            self.control.imageView.image = isSelected ? selectedImage : self.item.image
        }
         
        let color: UIColor = isSelected ? .blue : .black
        self.control.imageView.tintColor = color
        self.control.titleLabel.textColor = color
    }
    
    @objc
    open func provideDidSelected() {
        self.didSelected?()
    }
}

// MARK: - Control
extension TabBarItemView {
    
    open class Control: UIControl {
        
        // MARK: - Props
        public lazy var imageView: UIImageView = {
            let result = UIImageView()
            
            return result
        }()
        
        public lazy var titleLabel: UILabel = {
            let result = UILabel()
            result.font = .systemFont(ofSize: 14)
            result.textAlignment = .center
            
            return result
        }()
        
        open var imageSize: CGSize = .init(width: 30, height: 30) {
            didSet {
                self.setupViews()
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
        
        // MARK: - Methods
        open func setupViews() {
            [self.imageView, self.titleLabel].forEach({
                $0.removeFromSuperview()
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview($0)
            })
            
            NSLayoutConstraint.activate([
                self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
                self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                self.imageView.widthAnchor.constraint(equalToConstant: self.imageSize.width),
                self.imageView.heightAnchor.constraint(equalToConstant: self.imageSize.height),
                
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        
    }
    
}

// MARK: - BadgeView
extension TabBarItemView {
    
    open class BadgeView: UIView {
        
        // MARK: - Props
        public lazy var titleLabel: UILabel = {
            let result = UILabel()
            result.font = .systemFont(ofSize: 12, weight: .medium)
            result.textAlignment = .center
            result.textColor = .white
            
            return result
        }()
        
        // MARK: - Init
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setupViews()
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            self.setupViews()
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            
            self.layer.cornerRadius = self.bounds.height / 2
        }
        
        // MARK: - Methods
        open func setupViews() {
            self.titleLabel.removeFromSuperview()
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.titleLabel)
            
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: 16),
                self.heightAnchor.constraint(equalToConstant: 16),
                
                self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
                self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
                self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
                self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
            ])
        }
        
    }
    
}
