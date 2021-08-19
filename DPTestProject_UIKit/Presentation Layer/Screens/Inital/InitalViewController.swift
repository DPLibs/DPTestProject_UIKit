//
//  InitalViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 20.07.2021.
//

import Foundation
import UIKit

// MARK: - ViewControllerInput
protocol InitalViewControllerInput: DPViewControllerInput { }

class InitalViewController: DPViewController, InitalViewControllerInput {
    
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
        result.textColor = AppTheme.current.mainTextColor

        return result
    }()

    // MARK: - Lifecycle
    init(model: InitalViewModel) {
        super.init(_model: model)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            guard let self = self else { return }
            
            self._router?.showMain()
        }
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
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
    
    override func setupModel() {
        super.setupModel()
        
        self.titleLabel.text = self.model?.title
    }
}
