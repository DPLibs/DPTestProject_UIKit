//
//  NewsDetailViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 17.08.2021.
//

import Foundation
import UIKit

// MARK: - ViewControllerInput
protocol NewsDetailViewControllerInput: DPViewControllerInput { }

class NewsDetailViewController: DPViewController, NewsDetailViewControllerInput {
    
    // MARK: - Props
    var model: NewsDetailViewModelInput? {
        get {
            self._model as? NewsDetailViewModelInput
        }
        set {
            self._model = newValue
        }
    }

    // MARK: - Lifecycle
    init(model: NewsDetailViewModel) {
        super.init(_model: model)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    override func setupComponets() {
        self.navigationItem.title = "News Detail"
    }
    
    override func setupStyles() {
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
}
