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

class NewsListViewController: DPCastViewController<NewsListViewModel, DPViewRouter, DPViewErrorHandler>, NewsListViewControllerInput {
    
    // MARK: - Props
    lazy var tableView: DPTableView = {
        let result = DPTableView()
        result.backgroundColor = AppTheme.current.mainBackgroundColor
        result.registerCellClasses([NewsListTableRowCell.self])
        result.refreshControl = .init()
        
        return result
    }()

    // MARK: - Methods
    override func loadView() {
        super.loadView()
        
        self.view = self.tableView
    }
    
    override func setupComponets() {
        self.navigationItem.title = "News List"
        self.navigationItem.rightBarButtonItems = [
            .init(title: "Add", style: .plain, target: self, action: #selector(self.tapAdd)),
            .init(title: "Delete", style: .plain, target: self, action: #selector(self.tapDelete))
        ]
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
    
    override func updateComponets() {
        self.model?.didGetList = { [weak self] lists in
            let rows = lists.map({ NewsListTableRowCell.Model(title: $0, didTap: nil) })

            self?.tableView.reloadData(with: [.init(rows: rows)])
        }
        
        self.model?.getList()
    }
    
    @objc
    private func tapAdd() {
        let sections: [DPTableSectionModel] = [
            .init(rows: [
                NewsListTableRowCell.Model(title: "New section", didTap: nil)
            ])
        ]
        
        self.tableView.performBatchUpdates(withUpdates: [
            .insertSections(sections, at: .init(integer: 0), with: .top)
        ])
    }
    
    @objc
    private func tapDelete() {
        self.tableView.performBatchUpdates(withUpdates: [
            .deleteSections(at: .init(integer: 0), with: .left)
        ])
    }
    
}
