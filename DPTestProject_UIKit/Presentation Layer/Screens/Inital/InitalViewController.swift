//
//  InitalViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation
import UIKit

protocol InitalViewControllerInput: ViewControllerInput { }

class InitalViewController: ViewController, InitalViewControllerInput {
    
    // MARK: - Props
    var model: InitalViewModelInput? {
        get {
            self._model as? InitalViewModelInput
        }
        set {
            self._model = newValue
        }
    }
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.textColor = .black

        return result
    }()

    // MARK: - Lifecycle
    init(model: InitalViewModel) {
        super.init(_model: model)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    override func setupComponets() {
        self.titleLabel.removeFromSuperview()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    override func setupStyles() {
        self.view.backgroundColor = .yellow
    }
    
    override func setupModel() {
        self.titleLabel.text = self.model?.title
    }
}
