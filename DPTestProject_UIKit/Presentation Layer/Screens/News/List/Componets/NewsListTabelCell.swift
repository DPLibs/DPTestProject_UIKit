//
//  NewsListTabelCell.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation
import UIKit

class NewsListTableRowView: DPTableRowView<NewsListTableRowView.Row> {
    
    // MARK: - Static
    class Row: DPTableRow {
        
        override var cellIdentifier: String? {
            "NewsListTableRowView"
        }
        
        let title: String
        
        init(title: String, didTap: (() -> Void)?) {
            self.title = title
            
            super.init(didTap: didTap)
        }
        
    }
    
    // MARK: - Props
    lazy var titleLabel: UILabel = .init()
    
    // MARK: - Methods
    override func setupViews() {
        super.setupViews()
        
        self.contentView.backgroundColor = AppTheme.current.mainBackgroundColor
        
        self.titleLabel.removeFromSuperview()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    override func updateViews() {
        print("!!!")
        guard let model = self.viewModel else { return }
        
        self.titleLabel.text = model.title
    }
    
}
