//
//  ChangeAppThemeTableCell.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 25.07.2021.
//

import Foundation
import UIKit

class ChangeAppThemeTableCell: UITableViewCell {
    
    class Model {
        
        enum Switcher {
            case light
            case dark
            case useSystem
            
            var title: String {
                switch self {
                case .light:
                    return "Light"
                case .dark:
                    return "Dark"
                case .useSystem:
                    return "Use system"
                }
            }
        }
        
        struct Item {
            let switcher: Switcher
            let value: Bool
        }
        
        var style: AppTheme.Style {
            didSet {
                self.setupItems()
                AppTheme.current = .init(style: self.style)
            }
        }
        
        var useSystemStyle: Bool {
            didSet {
                self.setupItems()
                AppTheme.useSystemStyle = self.useSystemStyle
            }
        }
        
        private(set) var items: [Item] = []
        
        private func setupItems() {
            self.items = [
                .init(switcher: .light, value: self.style == .light && !self.useSystemStyle),
                .init(switcher: .dark, value: self.style == .dark && !self.useSystemStyle),
                .init(switcher: .useSystem, value: self.useSystemStyle)
            ]
        }
        
        init() {
            self.style = AppTheme.current.style
            self.useSystemStyle = AppTheme.useSystemStyle
            self.setupItems()
        }
    }
    
    static let reuseIdentifier: String = "ChangeAppThemeTableCell"
    
    var model: Model? {
        didSet {
            self.updateViews()
        }
    }
    
    override var reuseIdentifier: String? {
        ChangeAppThemeTableCell.reuseIdentifier
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
    
    lazy var stackView: UIStackView = {
        let result = UIStackView()
        result.axis = .vertical
        result.spacing = 8
        
        return result
    }()
    
    lazy var lightSwitcher: UISwitch = {
        let result = UISwitch()
        result.addTarget(self, action: #selector(self.didTapSwitcher(_:)), for: .valueChanged)
        
        return result
    }()
    
    lazy var darkSwitcher: UISwitch = {
        let result = UISwitch()
        result.addTarget(self, action: #selector(self.didTapSwitcher(_:)), for: .valueChanged)
        
        return result
    }()
    
    lazy var useSystemSwitcher: UISwitch = {
        let result = UISwitch()
        result.addTarget(self, action: #selector(self.didTapSwitcher(_:)), for: .valueChanged)
        
        return result
    }()
    
    func setupViews() {
        self.contentView.backgroundColor = AppTheme.current.mainBackgroundColor
        
        self.stackView.removeFromSuperview()
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func updateViews() {
        guard let model = self.model else { return }
        
        self.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        let itemsViews: [UIView] = model.items.map({ item in
            let switcher = item.switcher
            
            var switcherView: UISwitch {
                switch switcher {
                case .light:
                    return self.lightSwitcher
                case .dark:
                    return self.darkSwitcher
                case .useSystem:
                    return self.useSystemSwitcher
                }
            }
            
            return self.createItemView(title: switcher.title, value: item.value, switcher: switcherView)
        })
        
        itemsViews.forEach({
            self.stackView.addArrangedSubview($0)
        })
    }
    
    func createItemView(title: String, value: Bool, switcher: UISwitch) -> UIView {
        switcher.removeFromSuperview()
        switcher.isOn = value
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = AppTheme.current.mainTextColor
        
        let result = UIStackView(arrangedSubviews: [switcher, titleLabel])
        result.axis = .horizontal
        result.spacing = 16
        
        return result
    }
    
    @objc
    private func didTapSwitcher(_ sender: UISwitch) {
        switch sender {
        case self.lightSwitcher:
            self.model?.useSystemStyle = false
            self.model?.style = .light
        case self.darkSwitcher:
            self.model?.useSystemStyle = false
            self.model?.style = .dark
        case self.useSystemSwitcher:
            self.model?.useSystemStyle = true
        default:
            break
        }
        
        self.updateViews()
    }
    
}
