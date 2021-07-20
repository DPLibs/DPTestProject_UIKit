//
//  InitalViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation
import UIKit

protocol InitalViewControllerInput: ViewControllerInput { }

class InitalViewController: ViewController<InitalViewModel>, InitalViewControllerInput {
    
//    // MARK: - Props
//    var model: InitalViewModelInput? {
//        didSet {
//            self.setupModel()
//        }
//    }
//
//    lazy var titleLabel: UILabel = {
//        let result = UILabel()
//        result.textColor = .black
//
//        return result
//    }()
//
//    // MARK: - Lifecycle
//    init(model: InitalViewModel) {
//        super.init(nibName: nil, bundle: nil)
//
//        self.model = model
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setupComponets()
//        self.setupModel()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        self.setupStyles()
//    }
//
//    func setupComponets() {
//        self.titleLabel.removeFromSuperview()
//        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(self.titleLabel)
//
//        NSLayoutConstraint.activate([
//            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
//        ])
//    }
//
//    func setupStyles() {
//        self.view.backgroundColor = .yellow
//    }
//
//    func setupModel() {
//        self.titleLabel.text = self.model?.title
//    }
}
