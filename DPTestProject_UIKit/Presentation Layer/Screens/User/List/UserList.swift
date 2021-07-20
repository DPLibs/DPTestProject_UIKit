//
//  UserList.swift
//  PlaygroundIOS
//
//  Created by Дмитрий Поляков on 15.07.2021.
//  Copyright © 2021 Дмитрий Поляков. All rights reserved.
//

import Foundation
import UIKit
import WebKit

// MARK: - Model
protocol UserListModelInput {
    var userName: String? { get }
    
    func loadUserName()
}

protocol UserListModelOutput: AnyObject {
    func didLoadUserName(_ model: UserListModelInput)
}

class UserListModel: UserListModelInput {
    weak var output: UserListModelOutput?
    
    var userName: String?
    
    func loadUserName() {
        self.userName = "userName"
        
        self.output?.didLoadUserName(self)
    }
}

// MARK: - Controller
protocol UserListViewControllerInput: AnyObject {}

class UserListViewController: UIViewController, UserListViewControllerInput {
    
    lazy var model: UserListModelInput = {
        let result = UserListModel()
        result.output = self
        
        return result
    }()
    
    lazy var userDetailViewController: UserDetailViewControllerInput = {
        let result = UserDetailViewController()
        self.addChild(result)
        result.didMove(toParent: self)
        
        return result
    }()
    
    var userListView: UserListView? {
        self.view as? UserListView
    }
    
    override func loadView() {
        self.view = UserListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userListView?.userDetailView = self.userDetailViewController.userDetailView
        self.model.loadUserName()
    }
    
}

extension UserListViewController: UserListModelOutput {
    
    func didLoadUserName(_ model: UserListModelInput) {
        self.userListView?.userNameLabel.text = model.userName
    }

}

// MARK: - View
class UserListView: UIView {
    
    lazy var userNameLabel: UILabel = {
        let result = UILabel()
        result.textColor = .black
        result.font = UIFont.systemFont(ofSize: 16)
        
        return result
    }()
    
    var userDetailView: UserDetailView? {
        didSet {
            self.userDetailView?.removeFromSuperview()
            guard let userDetailView = self.userDetailView else { return }
            
            userDetailView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(userDetailView)
            
            NSLayoutConstraint.activate([
                userDetailView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
                userDetailView.widthAnchor.constraint(equalToConstant: 200),
                userDetailView.heightAnchor.constraint(equalToConstant: 200),
                userDetailView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .green
        
        self.userNameLabel.removeFromSuperview()
        self.userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.userNameLabel)
        
        NSLayoutConstraint.activate([
            self.userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.userNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}


// MARK: - Detail

// MARK: - Model
protocol UserDetailModelInput {
    var randomDetail: String? { get }
    
    func loadRandomDetail()
}

protocol UserDetailModelOutput: AnyObject {
    func didLoadRandomDetail(_ model: UserDetailModelInput)
}

class UserDetailModel: UserDetailModelInput {
    weak var output: UserDetailModelOutput?
    
    var randomDetail: String?
    
    func loadRandomDetail() {
        self.randomDetail = Int.random(in: 0...1000).description
        
        self.output?.didLoadRandomDetail(self)
    }
}

// MARK: - Controller
protocol UserDetailViewControllerInput: AnyObject {
    var userDetailView: UserDetailView? { get }
}

class UserDetailViewController: UIViewController, UserDetailViewControllerInput {
    
    lazy var model: UserDetailModelInput = {
        let result = UserDetailModel()
        result.output = self
        
        return result
    }()
    
    var userDetailView: UserDetailView? {
        self.view as? UserDetailView
    }
    
    override func loadView() {
        self.view = UserDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userDetailView?.randomButton.addTarget(self, action: #selector(self.tapButton(_:)), for: .touchUpInside)
    }
    
    @objc
    private func tapButton(_ button: UIButton) {
        switch button {
        case self.userDetailView?.randomButton:
            self.model.loadRandomDetail()
        default:
            break
        }
    }
    
}

extension UserDetailViewController: UserDetailModelOutput {
    
    func didLoadRandomDetail(_ model: UserDetailModelInput) {
        self.userDetailView?.randomDetailLabel.text = model.randomDetail
    }
    
}

// MARK: - View
class UserDetailView: PassiveView {
    
    lazy var randomDetailLabel: UILabel = {
        let result = UILabel()
        result.textColor = .black
        result.font = UIFont.systemFont(ofSize: 16)
        
        return result
    }()
    
    lazy var randomButton: UIButton = {
        let result = UIButton(type: .system)
        result.setTitle("Randomize", for: .normal)
        
        return result
    }()
    
    override func setupViews() {
        self.backgroundColor = .gray
        
        self.randomDetailLabel.removeFromSuperview()
        self.randomDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.randomDetailLabel)
        
        NSLayoutConstraint.activate([
            self.randomDetailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.randomDetailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        self.randomButton.removeFromSuperview()
        self.randomButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.randomButton)
        
        NSLayoutConstraint.activate([
            self.randomButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.randomButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}

// MARK: - PassiveView

public protocol PassiveViewModel {}

open class PassiveView: UIView {
    
    open var viewModel: PassiveViewModel? {
        didSet {
            self.updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    open func setupViews() {
        self.updateViews()
    }
    
    open func updateViews() { }
    
}
