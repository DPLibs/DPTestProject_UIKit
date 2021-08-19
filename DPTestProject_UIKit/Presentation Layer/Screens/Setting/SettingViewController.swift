//
//  MainViewController.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 23.07.2021.
//

import Foundation
import UIKit

// MARK: - ViewControllerInput
protocol SettingViewControllerInput: DPViewControllerInput { }

class SettingViewController: DPViewController, SettingViewControllerInput {
    
    // MARK: - Props
    var model: SettingViewModelInput? {
        get {
            self._model as? SettingViewModelInput
        }
        set {
            self._model = newValue
        }
    }
    
    lazy var tableView: UITableView = {
        let result = UITableView()
        result.backgroundColor = .clear
        result.register(ChangeAppThemeTableCell.self, forCellReuseIdentifier: ChangeAppThemeTableCell.reuseIdentifier)
        result.dataSource = self
        
        return result
    }()
    
    var tableCellsModels: [Any] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Lifecycle
    init(model: SettingViewModel) {
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
        self.navigationItem.title = "Settings"
        self.tableCellsModels = [ChangeAppThemeTableCell.Model()]
        
        self.notificationObserver.observe([AppTheme.didSetCurrentNotification]) { [weak self] notification in
            guard notification.name == AppTheme.didSetCurrentNotification else { return }
                    
            self?.setupComponets()
            self?.setupStyles()
        }
    }
    
    override func setupStyles() {
        self.view.backgroundColor = AppTheme.current.mainBackgroundColor
    }
}

// MARK: - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableCellsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.tableCellsModels.indices.contains(indexPath.row) else { return .init() }
        
        switch self.tableCellsModels[indexPath.row] {
        case let model as ChangeAppThemeTableCell.Model:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChangeAppThemeTableCell.reuseIdentifier, for: indexPath) as? ChangeAppThemeTableCell else { return .init() }
            cell.model = model
            
            return cell
        default:
            return .init()
        }
    }
    
}
