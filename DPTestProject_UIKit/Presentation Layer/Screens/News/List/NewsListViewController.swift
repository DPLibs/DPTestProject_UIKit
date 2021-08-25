//
//  NewsListViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation
import UIKit

// MARK: - ViewControllerInput
protocol NewsListViewControllerInput: DPViewControllerInput { }

class NewsListViewController: DPViewController, NewsListViewControllerInput {
    
    // MARK: - Props
    var model: NewsListViewModelInput? {
        get {
            self._model as? NewsListViewModelInput
        }
        set {
            self._model = newValue
        }
    }
    
    lazy var tableView: DPTableView = {
        let result = DPTableView()
        result.backgroundColor = AppTheme.current.mainBackgroundColor
        result.register(NewsListTabelCell.self, forCellReuseIdentifier: "NewsListTabelCell")
        result.refreshControl = .init()
        result.adapter = .init()
        
        return result
    }()

    // MARK: - Lifecycle
    init(model: NewsListViewModel) {
        super.init(_model: model)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view = self.tableView
    }
    
    // MARK: - Methods
    override func setupComponets() {
        self.navigationItem.title = "News List"
    }
    
    override func setupStyles() {
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
    
    override func setupModel() {
        self.model?.didGetList = { [weak self] lists in
            let rows = lists.map({ NewsListTabelCell.Model(title: $0, didTap: nil) })

            self?.tableView.adapter?.reload([.init(rows: rows)])
        }
        
        self.model?.getList()
    }
}
