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

class InitalViewController: DPCastViewController<InitalViewModel, DPViewRouter, DPViewErrorHandler>, InitalViewControllerInput {
    
    // MARK: - Props
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.textColor = AppTheme.current.mainTextColor

        return result
    }()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            guard let self = self else { return }
            
            self.router?.showMain()
        }
    }
    
    // MARK: - Methods
    override func setupComponets() {
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
        
        self.titleLabel.removeFromSuperview()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)

        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    override func updateComponets() {
        self.titleLabel.text = self.model?.title
    }
}
