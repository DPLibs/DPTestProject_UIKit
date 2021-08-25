//import Foundation
//import UIKit
//
//open class BarButtonItemView: UIView {
//    
//    lazy var button: UIButton = {
//        let button = UIButton(type: .close)
//        button.addTarget(self, action: #selector(self.tapButton), for: .touchUpInside)
//        
//        return button
//    }()
//    
//    lazy var widthConstraint: NSLayoutConstraint = {
//        let result = self.widthAnchor.constraint(equalToConstant: self.size.width)
//        result.isActive = true
//        
//        return result
//    }()
//    
//    lazy var heightConstraint: NSLayoutConstraint = {
//        let result = self.heightAnchor.constraint(equalToConstant: self.size.height)
//        result.isActive = true
//        
//        return result
//    }()
//    
//    open var handler: (() -> Void)?
//    
//    open var size: CGSize = .init(width: 24, height: 24) {
//        didSet {
//            self.setupViews()
//        }
//    }
//    
//    init(handler: (() -> Void)?) {
//        super.init(frame: .zero)
//        
//        self.handler = handler
//        self.setupViews()
//    }
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.setupViews()
//    }
//    
//    required public init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        self.setupViews()
//    }
//
//    open func setupViews() {
//        self.widthConstraint.constant = self.size.width
//        self.heightConstraint.constant = self.size.height
//        
//        self.button.removeFromSuperview()
//        self.button.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(self.button)
//        
//        NSLayoutConstraint.activate([
//            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            self.button.topAnchor.constraint(equalTo: self.topAnchor),
//            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
//    }
//    
//    @objc
//    open func tapButton() {
//        self.handler?()
//    }
//    
//}
