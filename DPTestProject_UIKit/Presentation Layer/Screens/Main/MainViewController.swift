//
//  MainViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation
import UIKit

// MARK: - ViewControllerInput
protocol MainViewControllerInput: ViewControllerInput { }

class MainViewController: ViewController, MainViewControllerInput {
    
    // MARK: - Props
    var model: MainViewModelInput? {
        get {
            self._model as? MainViewModelInput
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
    init(model: MainViewModel) {
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
        self.view.backgroundColor = .red
    }
    
    override func setupModel() {
        super.setupModel()
        
        self.titleLabel.text = self.model?.title
    }
}

// MARK: - ViewModelOutput
extension InitalViewController: MainViewModelOutput { }
