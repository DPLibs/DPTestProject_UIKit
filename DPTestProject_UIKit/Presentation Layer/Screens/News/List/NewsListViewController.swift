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
    
    lazy var tableView: UITableView = {
        let result = UITableView()
        result.backgroundColor = AppTheme.current.mainBackgroundColor
        result.register(NewsListTabelCell.self, forCellReuseIdentifier: NewsListTabelCell.reuseIdentifier)
        result.dataSource = self
        result.delegate = self
        
        return result
    }()
    
    var tableCellsModels: [Any] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.dpNavigationController?.navigationBarView = .init(leftView: .init(handler: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dpNavigationController?.navigationBarView = nil
    }
    
    override func setupComponets() {
        self.navigationItem.title = "News List"
        self.tableCellsModels = [ChangeAppThemeTableCell.Model()]
    }
    
    override func setupStyles() {
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
    
    override func setupModel() {
        self.model?.didGetList = { [weak self] lists in
            self?.tableCellsModels = lists.map({ NewsListTabelCell.Model(title: $0) })
        }
        
        self.model?.getList()
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableCellsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.tableCellsModels.indices.contains(indexPath.row) else { return .init() }
        
        switch self.tableCellsModels[indexPath.row] {
        case let model as NewsListTabelCell.Model:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTabelCell.reuseIdentifier, for: indexPath) as? NewsListTabelCell else { return .init() }
            cell.model = model
            
            return cell
        default:
            return .init()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            self._router?.showNewsDetail(model: .init())
        default:
            self._router?.push(viewController: NewsListViewController(model: .init()), animated: true)
        }
    }
    
}
