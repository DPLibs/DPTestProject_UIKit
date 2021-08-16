//
//  NewsListTabelCell.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 16.08.2021.
//

import Foundation
import UIKit

class NewsListTabelCell: UITableViewCell {
    
    class Model {
        let title: String
        
        init(title: String) {
            self.title = title
        }
    }
    
    static let reuseIdentifier: String = "NewsListTabelCell"
    
    var model: Model? {
        didSet {
            self.updateViews()
        }
    }
    
    override var reuseIdentifier: String? {
        NewsListTabelCell.reuseIdentifier
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupViews()
    }
    
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        
        return result
    }()
    
    func setupViews() {
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
    
    func updateViews() {
        guard let model = self.model else { return }
        
        self.titleLabel.text = model.title
    }
    
}
